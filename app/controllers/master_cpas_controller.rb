class MasterCpasController < ApplicationController
  before_action :set_master_cpa, only: [:show, :edit, :update, :destroy]

  # GET /master_cpas
  # GET /master_cpas.json
  def index
    @master_cpas = MasterCpa.all
    new_cpa_membership = ["Unlimited CPA CPE Membership", "Unlimited CPA CPE Membership (Auto-Renew)"]
    @cpa_memerships = SCustomer.where(product_1: new_cpa_membership).count
    @cpa_memerships_new = SCustomer.where(product_1: new_cpa_membership).where(purchase: '2020-06-23').all
    @cpa_memerships_match = MasterCpa.where(membership: true).count

    if params['run'] == 'cpa_new'
      customer = SCustomer.select(:product_1, :lic_state, :lic_num)
      master = MasterCpa.select(:lic_st, :lic)
      SCustomer.where(product_1: new_cpa_membership).limit(50).each do |customer|
        MasterCpa.where(lic_st: customer.lic_state).where(lic: customer.lic_num).update_all membership: true, uid: customer.uid
      end
      redirect_to master_cpas_path(done: 'cpa_new')
    end
  end

  # GET /master_cpas/1
  # GET /master_cpas/1.json
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
