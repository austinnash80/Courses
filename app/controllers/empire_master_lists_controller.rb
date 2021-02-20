class EmpireMasterListsController < ApplicationController
  before_action :set_empire_master_list, only: [:show, :edit, :update, :destroy]

  # GET /empire_master_lists
  # GET /empire_master_lists.json
# NEW YORK
  def ny_week

    @week_s = Date.strptime(params['week'], "%m/%d/%Y")
    @week_e = @week_s + 6.days
    @matched = EmpireMasterMatch.where(source: 'NY').pluck(:lid)

    @total_users = [].uniq
    @renewed_this_cycle = [].uniq
    @new_this_cycle = [].uniq
    not_renewed_this_cycle = [].uniq

    @dup_not_renewed_this_cycle = []
    @dup_new_this_cycle = []
    @dup_renewed_this_cycle = []

    EmpireMasterList.where(source: 'NY').where(lid: @matched).where(exp_date: @week_s..@week_e).each do |empire_master_list|
        empire_master_match = EmpireMasterMatch.find_by(lid: empire_master_list.lid)
        @total_users.push(empire_master_match.uid)
    end

    uid_dup = []
    EmpireCustomer.where(uid: @total_users).where.not(uid: uid_dup).order(p_date: :desc).each do |empire_customer|
      uid_dup.push(empire_customer.uid)
      purchases = EmpireCustomer.where(uid: empire_customer.uid).pluck(:p_date)
      master = EmpireMasterMatch.find_by(uid: empire_customer.uid)
      exp_date = EmpireMasterList.where(lid: master.lid).pluck(:exp_date)
      empire_customer.p_date > exp_date[0] - 20.months && purchases.length > 1 ? @renewed_this_cycle.push(empire_customer.uid) : empire_customer.p_date > exp_date[0] - 20.months ? @new_this_cycle.push(empire_customer.uid) : @not_renewed_this_cycle.push(empire_customer.uid)
    end

    @not_renewed_this_cycle = not_renewed_this_cycle - @renewed_this_cycle


  end

  def ny
    @uid = EmpireCustomer.where(lic_state: 'NY').pluck(:uid)
    @list = EmpireMasterList.where(source: 'NY').first(1).pluck(:list)
    @matches = EmpireMasterMatch.where(list: @list).pluck(:uid)
    @no_match = EmpireMasterNoMatch.where(list: @list).where(double: false).pluck(:uid)
    @double = EmpireMasterNoMatch.where(list: @list).where(double: true).pluck(:uid)
    @yes = []

# AUTO MATCH
    if params['path'] == 'search'
      customer = EmpireCustomer.find(params['id'])
      lid = EmpireMasterList.where(source: 'NY').where(license_number: customer.license_num).pluck(:lid)
      if lid.present?
        new = EmpireMasterMatch.create(
          uid: customer.uid,
          last_name: customer.lname,
          list: @list[0],
          source: 'NY',
          lid: lid[0],
          search_date: Time.current
        )
         new.save
        redirect_to ny_empire_master_lists_path()
       end
    end
  ## SEARCH - IF NO MATCH FOUND
    if params['path'] == 'no_match'
      customer = EmpireCustomer.find(params['id'])
      new = EmpireMasterNoMatch.create(
        uid: customer.uid,
        last_name: customer.lname,
        list: @list[0],
        source: 'NY',
        search_date: Time.current,
        double: false
      )
       new.save
       redirect_to ny_empire_master_lists_path()
    end
  ## SEARCH - IF Double FOUND
    if params['path'] == 'double'
      customer = EmpireCustomer.find(params['id'])
      new = EmpireMasterNoMatch.create(
        uid: customer.uid,
        last_name: customer.lname,
        list: @list[0],
        source: 'NY',
        search_date: Time.current,
        double: true
      )
       new.save
       redirect_to ny_empire_master_lists_path()
    end
  ## SEARCH - IF MATCH FOUND
    if params['path'] == 'match'
      customer = EmpireCustomer.find(params['id'])
      new = EmpireMasterMatch.create(
        uid: customer.uid,
        last_name: customer.lname,
        list: @list[0],
        source: 'NY',
        lid: params['lid'],
        search_date: Time.current
      )
       new.save
       redirect_to ny_empire_master_lists_path()
    end

    # if params['path'] == 'auto_match'
    #   EmpireCustomer.where(lic_state: 'NY').where.not(uid: @no_match).where.not(uid: @matches).where.not(uid: @double).each do |customer|
    #     lid = EmpireMasterList.where(source: 'NY').where(list: @list).where(license_number: customer.license_num).where(last_name: customer.lname).pluck(:lid)
    #     if lid.present?
    #       @yes.push(1)
    #     end
    #   end
    #
    #   redirect_to ny_empire_master_lists_path(), notice: 'Auto-match complete'
    # end



  end

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
    @ind = EmpireMasterList.where(source: 'IND').pluck(:list)

#Delete List
    if params['confirm'] == 'yes'
      EmpireMasterList.where(source: params['delete']).delete_all
      redirect_to empire_master_lists_path
    end

    # EXPORT FOR NY PAGE
      if params['path'] = 'ny_export_empire_master_list'
        respond_to do |format|
          format.html
          format.csv { send_data EmpireMasterList.where(source: 'NY').to_csv, filename: "ny-empire_master_list-#{Date.today}.csv" }
        end
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
    # @page = EmpireRcState.find(params['id'].to_i)
    redirect_to empire_rc_states_path(upload: 'done', id: params['id']), notice: "Upload Complete"
    # redirect_to upload_list_empire_rc_states_path(id: params['id'], st: params['st'], upload: 'complete'), notice: "Upload Complete"
    # redirect_to empire_master_lists_path, notice: "Upload Complete"
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
