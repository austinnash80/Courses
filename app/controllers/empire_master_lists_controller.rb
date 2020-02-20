class EmpireMasterListsController < ApplicationController
  before_action :set_empire_master_list, only: [:show, :edit, :update, :destroy]

  # GET /empire_master_lists
  # GET /empire_master_lists.json
  def index
    @empire_master_lists = EmpireMasterList.all

    # @states = EmpireMasterList.all.group_by(&:list)
    @ca = EmpireMasterList.where(source: 'CA').pluck(:list)
    @ny = EmpireMasterList.where(source: 'NY').pluck(:list)
    @nm = EmpireMasterList.where(source: 'NM').pluck(:list)
    @ut = EmpireMasterList.where(source: 'UT').pluck(:list)
    @wa = EmpireMasterList.where(source: 'WA').pluck(:list)
    @mo_b = EmpireMasterList.where(source: 'MO_B').pluck(:list)
    @pa = EmpireMasterList.where(source: 'PA').pluck(:list)
    @nc = EmpireMasterList.where(source: 'NC').pluck(:list)

#Delete List
    if params['confirm'] == 'yes'
      EmpireMasterList.where(source: params['delete']).delete_all
      redirect_to empire_master_lists_path
    end

   end

  # GET /empire_master_lists/1
  # GET /empire_master_lists/1.json
  def show
  end

  # GET /empire_master_lists/new
  def new
    @empire_master_list = EmpireMasterList.new
  end

  # GET /empire_master_lists/1/edit
  def edit
  end

  # POST /empire_master_lists
  # POST /empire_master_lists.json
  def create
    @empire_master_list = EmpireMasterList.new(empire_master_list_params)

    respond_to do |format|
      if @empire_master_list.save
        format.html { redirect_to @empire_master_list, notice: 'Empire master list was successfully created.' }
        format.json { render :show, status: :created, location: @empire_master_list }
      else
        format.html { render :new }
        format.json { render json: @empire_master_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_master_lists/1
  # PATCH/PUT /empire_master_lists/1.json
  def update
    respond_to do |format|
      if @empire_master_list.update(empire_master_list_params)
        format.html { redirect_to @empire_master_list, notice: 'Empire master list was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_master_list }
      else
        format.html { render :edit }
        format.json { render json: @empire_master_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_master_lists/1
  # DELETE /empire_master_lists/1.json
  def destroy
    @empire_master_list.destroy
    respond_to do |format|
      format.html { redirect_to empire_master_lists_url, notice: 'Empire master list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    EmpireMasterList.my_import(params[:file])
    redirect_to empire_master_lists_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_master_list
      @empire_master_list = EmpireMasterList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_master_list_params
      params.require(:empire_master_list).permit(:lid, :source, :list, :license_number, :record_type, :lic_status, :iss_date_s, :iss_date, :exp_date_s, :expe_date, :first_name, :mi, :last_name, :company, :address_1, :address_2, :city, :state, :zip, :county, :extra_d, :extra_s, :extra_b, :exp_date, :email)
    end
end
