class MasterListsController < ApplicationController
  before_action :set_master_list, only: [:show, :edit, :update, :destroy]

  # GET /master_lists
  # GET /master_lists.json


  def index
    # @master_lists = MasterList.all.first(10)
    @master_lists_count = MasterList.all.count
    @master_lists_count_cpa = MasterList.where(who: 'CPA').all.count
    @master_lists_count_nomail = MasterList.where(no_mail: 'yes').all.count
    @master_lists_count_cpa_list = MasterList.where(who: 'CPA').first(1).pluck(:list)
    @master_lists_count_cpa_nomail = MasterList.where(who: 'CPA').where(no_mail: 'yes').all.count
    @master_lists_count_ea = MasterList.where(who: 'EA').all.count
    @master_lists_count_ea_list = MasterList.where(who: 'EA').first(1).pluck(:list)
    @master_lists_count_ea_nomail = MasterList.where(who: 'EA').where(no_mail: 'yes').all.count
    @master_lists_search_param = MasterList.where('lower(lname) = lower(?)', params['search']).or(MasterList.where(:zip => params['search']))

    # Find Duplicates / destroy duplicates
    # ids = MasterList.where(who: 'EA').select("MIN(id) as id").group(:lid).collect(&:id)
    # MasterList.where(who: 'EA').where.not(id: ids).destroy_all
  end

  def no_mail
    @no_mails = MasterList.where(no_mail: 'yes').order(updated_at: :DESC).all
    @no_mails_count = MasterList.where(no_mail: 'yes').count

     @no_mail_export = MasterList.where(no_mail: 'yes').all


    respond_to do |format|
      format.html
      format.csv { send_data @no_mail_export.to_csv, filename: "No_mail-#{Date.today}.csv" }
    end

  end

  def mailings
    @ea_list = (MasterList.last(1).pluck(:list))[0]
    @ea_total = MasterList.where(who: 'EA', list: @ea_list).count
    @pacific_mailing = MasterList.where(who: 'EA', list: @ea_list).where.not(no_mail: true).all
  end

  # GET /master_lists/1
  # GET /master_lists/1.json
  def show
  end

  # GET /master_lists/new
  def new
    @master_list = MasterList.new
  end

  # GET /master_lists/1/edit
  def edit
  end

  # POST /master_lists
  # POST /master_lists.json
  def create
    @master_list = MasterList.new(master_list_params)

    respond_to do |format|
      if @master_list.save
        format.html { redirect_to @master_list, notice: 'Master list was successfully created.' }
        format.json { render :show, status: :created, location: @master_list }
      else
        format.html { render :new }
        format.json { render json: @master_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_lists/1
  # PATCH/PUT /master_lists/1.json
  def update
    respond_to do |format|
      if @master_list.update(master_list_params)
        format.html { redirect_to @master_list, notice: 'Master list was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_list }
      else
        format.html { render :edit }
        format.json { render json: @master_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_lists/1
  # DELETE /master_lists/1.json
  def destroy
    @master_list.destroy
    respond_to do |format|
      format.html { redirect_to master_lists_url, notice: 'Master list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    MasterList.my_import(params[:file])
    redirect_to master_lists_path, notice: "Upload Complete"
  end

  def remove_all
    MasterList.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to master_lists_path
  end

  def no_mail_add
    MasterList.where(id: params['master_list_id']).update_all no_mail: 'yes'
    redirect_to master_lists_path, notice: "No Mail Added"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_list
      @master_list = MasterList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_list_params
      params.require(:master_list).permit(:who, :list, :lid, :lic, :fname, :mi, :lname, :suf, :co, :add2, :add, :city, :state, :zip, :no_mail)
    end
end
