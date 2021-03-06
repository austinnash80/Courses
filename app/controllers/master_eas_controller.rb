class MasterEasController < ApplicationController
  before_action :set_master_ea, only: [:show, :edit, :update, :destroy]

  # GET /master_eas
  # GET /master_eas.json
  def ea_customers
    ## IF NO MATCH FOUND
    if params['path'] == 'no_match'
      customer = SCustomer.find(params['id'])
      master_ea_list = MasterEa.all.limit(1).pluck(:list)
      new = MasterEaNoMatch.create(
        uid: customer.uid,
        lname: customer.lname,
        list: master_ea_list[0],
        search_date: Time.current
      )
       new.save
       redirect_to ea_customers_master_eas_path
    end
    ## IF MATCH FOUND
    if params['path'] == 'match'
      customer = SCustomer.find(params['id'])
      master_ea_list = MasterEa.all.limit(1).pluck(:list)
      new = MasterEaMatch.create(
        lid: params['lid'],
        uid: customer.uid,
        lname: customer.lname,
        list: master_ea_list[0],
        search_date: Time.current
      )
       new.save
       redirect_to ea_customers_master_eas_path
    end
    ## IF Double FOUND
    if params['path'] == 'double'
      customer = SCustomer.find(params['id'])
      master_ea_list = MasterEa.all.limit(1).pluck(:list)
      new = MasterEaDoubleAccount.create(
        lid: params['lid'],
        uid: customer.uid,
        lname: customer.lname,
        list: master_ea_list[0],
        search_date: Time.current
      )
       new.save
       redirect_to ea_customers_master_eas_path
    end

    ## Run Auto Match
    if params['path'] == 'run_match'
      list_name = MasterEa.first(1).pluck(:list)
      master_ea_no_matches = MasterEaNoMatch.where(list:list_name[0]).all.pluck(:uid)
      master_ea_matches = MasterEaMatch.where(list:list_name[0]).all.pluck(:uid)
      master_ea_double_account = MasterEaDoubleAccount.where(list:list_name[0]).all.pluck(:uid)
      matches = MasterEaMatch.pluck(:lid)
      des = ['ea', 'ea ']

        SCustomer.where(designation: des).where.not(zip: nil).where.not(uid: master_ea_no_matches).where.not(uid: master_ea_matches).where.not(uid: master_ea_double_account).all.each do |s_customer|
          lid = MasterEa.where(fname: s_customer.fname).where(lname: s_customer.lname).where("zip like ?", "#{s_customer.zip}%").pluck(:lid)
            if lid.present?
              new = MasterEaMatch.create(
                lid: lid[0],
                uid: s_customer.uid,
                lname: s_customer.lname,
                list: list_name[0],
                search_date: Time.current)
              new.save
          end
        end
      redirect_to ea_customers_master_eas_path()
    end




  end

  def no_mail_ea
    @no_mail_ea = MasterEa.where(no_mail: true).order(no_mail_date: :DESC).all

    respond_to do |format|
      format.html
      format.csv { send_data @no_mail_ea.to_csv, filename: "Sequoia-No-Mail-EA-#{Date.today}.csv" }
    end
  end

  def index
    @master_eas = MasterEa.all
    new_ea_membership = ["Unlimited EA CPE Membership", "Unlimited EA Membership (Auto-Renew)"]
    uid_master_ea = MasterEaMatch.pluck(:uid)
    no_match_ea = MasterEaNoMatch.pluck(:uid)
    @ea_new = SCustomer.where.not(uid: uid_master_ea).where(match: nil).where(product_1: new_ea_membership).where.not(uid: no_match_ea).order(purchase: :DESC).first(10)

    # Remove All
    if params['remove_all'] == 'yes' && params['confirm'] == 'yes'
      MasterEa.delete_all
      redirect_to master_eas_path(), note: 'Records Deleted'
    end
  end

  def search
    if params['match'].present?
      lid = params['lid'].to_i
      uid = params['uid'].to_i
      list = params['list']
      lname = params['lname']
      MasterEa.where(lid: lid).update_all uid: uid
      new = MasterEaMatch.create(
        uid: uid,
        lid: lid,
        list: list,
        lname: lname,
        search_date: Date.today,
      )
      new.save
      redirect_to master_eas_path, notice: "Match successfull for uid: #{uid} and lid: #{lid}"
    end

    zip = params['zip']
    lname = params['lname']
    state = params['state']
    uid = params['uid'].to_i

    if zip.present? && lname.blank? && state.blank?
      @search_results = MasterEa.where(zip: zip).all
    elsif zip.blank? && lname.present? && state.blank?
      @search_results = MasterEa.where(lname: lname).all
    elsif zip.blank? && lname.blank? && state.present?
      @search_results = MasterEa.where(st: state).all
    elsif zip.present? && lname.present? && state.blank?
      @search_results = MasterEa.where(zip: zip).where(lname: lname).all
    elsif zip.blank? && lname.present? && state.present?
      @search_results = MasterEa.where(lname: lname).where(st: state).all
    elsif zip.present? && lname.blank? && state.present?
      @search_results = MasterEa.where(zip: zip).where(st: state).all
    elsif zip.present? && lname.present? && state.present?
      @search_results = MasterEa.where(zip: zip).where(lname: lname).where(st: state).all
    elsif zip.blank? && lname.blank? && state.blank?
      @search_results = MasterEa.first(10)
    end
    @sequoia_customer = SCustomer.where(uid: uid).order(purchase: :DESC).all

    # if params['no_match'].present?
    #   uid = params['uid'].to_i
    #   SCustomer.where(uid: uid).update_all match: 'no'
    #   redirect_to master_eas_path, notice: "No match for UID: #{uid}"
    # end

    if params['no_mail'] == 'match'
      lid = params['lid'].to_i
      lname = params['lname']
      MasterEa.where(lid: lid).update_all no_mail: true, no_mail_date: Date.today
      redirect_to root_url, notice: "No mail updated for #{lname}"
    end

  end

  # GET /master_eas/1
  # GET /master_eas/1.json
  def show
  end

  # GET /master_eas/new
  def new
    @master_ea = MasterEa.new
  end

  # GET /master_eas/1/edit
  def edit
  end

  # POST /master_eas
  # POST /master_eas.json
  def create
    @master_ea = MasterEa.new(master_ea_params)

    respond_to do |format|
      if @master_ea.save
        format.html { redirect_to @master_ea, notice: 'Master ea was successfully created.' }
        format.json { render :show, status: :created, location: @master_ea }
      else
        format.html { render :new }
        format.json { render json: @master_ea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_eas/1
  # PATCH/PUT /master_eas/1.json
  def update
    respond_to do |format|
      if @master_ea.update(master_ea_params)
        format.html { redirect_to @master_ea, notice: 'Master ea was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_ea }
      else
        format.html { render :edit }
        format.json { render json: @master_ea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_eas/1
  # DELETE /master_eas/1.json
  def destroy
    @master_ea.destroy
    respond_to do |format|
      format.html { redirect_to master_eas_url, notice: 'Master ea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    MasterEa.my_import(params[:file])
    redirect_to master_eas_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_ea
      @master_ea = MasterEa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_ea_params
      params.require(:master_ea).permit(:lid, :list, :lic, :fname, :mi, :lname, :suf, :co, :add2, :add, :city, :st, :zip, :uid, :no_mail, :no_mail_date)
    end
end
