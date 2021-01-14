class MasterCpasController < ApplicationController
  before_action :set_master_cpa, only: [:show, :edit, :update, :destroy]

  # GET /master_cpas
  # GET /master_cpas.json
  def cpa_customers

    ## IF NO MATCH FOUND
    if params['path'] == 'no_match'
      customer = SCustomer.find(params['id'])
      master_cpa_list = MasterCpa.all.limit(1).pluck(:list)
      new = MasterCpaNoMatch.create(
        uid: customer.uid,
        lname: customer.lname,
        list: master_cpa_list[0],
        search_date: Time.current
      )
       new.save
       redirect_to cpa_customers_master_cpas_path
    end
    ## IF MATCH FOUND
    if params['path'] == 'match'
      customer = SCustomer.find(params['id'])
      master_cpa_list = MasterCpa.all.limit(1).pluck(:list)
      new = MasterCpaMatch.create(
        lid: params['lid'],
        uid: customer.uid,
        lname: customer.lname,
        list: master_cpa_list[0],
        search_date: Time.current
      )
       new.save
       redirect_to cpa_customers_master_cpas_path
    end

  end
def no_mail_cpa
  @no_mail_cpa = MasterCpa.where(no_mail: true).order(no_mail_date: :DESC).all

  respond_to do |format|
    format.html
    format.csv { send_data @no_mail_cpa.to_csv, filename: "Sequoia-No-Mail-cpa-#{Date.today}.csv" }
  end
end

  def index
    new_cpa_membership = ["Unlimited CPA CPE Membership", "Unlimited CPA CPE Membership (Auto-Renew)"]
    uid_master_cpa = MasterCpaMatch.pluck(:uid)
    # unmatched = SCustomer.where.not(uid: uid_master_cpa).where(match: nil).where(product_1: new_cpa_membership)
    no_match = MasterCpaNoMatch.pluck(:uid)
    @cpa_new = SCustomer.where.not(uid: uid_master_cpa).where(match: nil).where(product_1: new_cpa_membership).where.not(uid: no_match).order(purchase: :DESC).first(10)
    # @cpa_new_count = unmatched.count
    @cpa_export = MasterCpa.where.not(uid: nil)
    # @cpa_export = 1,2,3

    respond_to do |format|
      format.html
      format.csv { send_data @no_mail_cpa.to_csv, filename: "Sequoia-No-Mail-cpa-#{Date.today}.csv" }
    end



  end

  def search

    if params['match'].present?
      lid = params['lid'].to_i
      uid = params['uid'].to_i
      list = params['list']
      lname = params['lname']
      MasterCpa.where(lid: lid).update_all uid: uid, membership: true
      new = MasterCpaMatch.create(
        uid: uid,
        lid: lid,
        list: list,
        lname: lname,
        search_date: Date.today,
      )
      new.save
      redirect_to master_cpas_path, notice: "Match successfull for uid: #{uid} and lid: #{lid}"
    end

    zip = params['zip']
    lname = params['lname']
    state = params['state']
    uid = params['uid'].to_i

    if zip.present? && lname.blank? && state.blank?
      @search_results = MasterCpa.where(zip: zip).all
    elsif zip.blank? && lname.present? && state.blank?
      @search_results = MasterCpa.where(lname: lname).all
    elsif zip.blank? && lname.blank? && state.present?
      @search_results = MasterCpa.where(lic_st: state).all
    elsif zip.present? && lname.present? && state.blank?
      @search_results = MasterCpa.where(zip: zip).where(lname: lname).all
    elsif zip.blank? && lname.present? && state.present?
      @search_results = MasterCpa.where(lname: lname).where(lic_st: state).all
    elsif zip.present? && lname.blank? && state.present?
      @search_results = MasterCpa.where(zip: zip).where(lic_st: state).all
    elsif zip.present? && lname.present? && state.present?
      @search_results = MasterCpa.where(zip: zip).where(lname: lname).where(lic_st: state).all
    elsif zip.blank? && lname.blank? && state.blank?
      @search_results = MasterCpa.first(10)
    end
    @sequoia_customer = SCustomer.where(uid: uid).order(purchase: :DESC).all
    if params['no_match'].present?
      uid = params['uid'].to_i
      SCustomer.where(uid: uid).update_all match: 'no'
      redirect_to master_cpas_path, notice: "No match for UID: #{uid}"
    end
    if params['no_mail'] == 'match'
      lid = params['lid'].to_i
      lname = params['lname']
      MasterCpa.where(lid: lid).update_all no_mail: true, no_mail_date: Date.today
      redirect_to root_url, notice: "No mail updated for #{lname}"
    end
  end

  def show
  end

  # GET /master_cpas/new
  def new
    @master_cpa = MasterCpa.new
  end

  # GET /master_cpas/1/edit
  def edit
  end

  # POST /master_cpas
  # POST /master_cpas.json
  def create
    @master_cpa = MasterCpa.new(master_cpa_params)

    respond_to do |format|
      if @master_cpa.save
        format.html { redirect_to @master_cpa, notice: 'Master cpa was successfully created.' }
        format.json { render :show, status: :created, location: @master_cpa }
      else
        format.html { render :new }
        format.json { render json: @master_cpa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_cpas/1
  # PATCH/PUT /master_cpas/1.json
  def update
    respond_to do |format|
      if @master_cpa.update(master_cpa_params)
        format.html { redirect_to @master_cpa, notice: 'Master cpa was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_cpa }
      else
        format.html { render :edit }
        format.json { render json: @master_cpa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_cpas/1
  # DELETE /master_cpas/1.json
  def destroy
    @master_cpa.destroy
    respond_to do |format|
      format.html { redirect_to master_cpas_url, notice: 'Master cpa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    MasterCpa.my_import(params[:file])
    redirect_to master_cpas_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_cpa
      @master_cpa = MasterCpa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_cpa_params
      params.require(:master_cpa).permit(:list, :string, :lid, :lic, :lic_st, :fname, :mi, :lname, :suf, :co, :add2, :add, :city, :st, :zip, :membership, :ethics, :uid)
    end
end
