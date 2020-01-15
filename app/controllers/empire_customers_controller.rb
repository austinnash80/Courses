class EmpireCustomersController < ApplicationController
  # before_action :all_empire_customers, only: [:index, :create]
  before_action :set_empire_customer, only: [:show, :edit, :update, :destroy]
  # respond_to :html, :js

  # GET /empire_customers
  # GET /empire_customers.json
  def index
    run_data
    # @empire_customers_count = EmpireCustomer.all.count
    @empire_customers = EmpireCustomer.order(:e_id).last(1)
    @uids = EmpireCustomer.pluck(:uid)
    @id = '3'
    @total_purchases = EmpireCustomer.all.count
    customers = EmpireCustomer.all.pluck(:uid)
    @unique_customers = customers.uniq.count
    states = EmpireCustomer.all.pluck(:lic_state)
    @unique_states = states.uniq.count
    newest = EmpireCustomer.pluck(:e_id).max
    @last_update = EmpireCustomer.where(e_id: newest).pluck(:p_date)

# State Table
  @states = EmpireCustomer.all.group_by(&:lic_state)
  # @states = s.group_by{|h| h[:e_id]}.map{[k,v.size]}.to_hash
    if params['search'].present?
      @empire_customers_search = EmpireCustomer.where('lower(lname) = ?', params['search'].downcase).or(EmpireCustomer.where(uid: params['search']))
    end
  end

  def rc_marketing
    rc_marketing_date
    rc_marketing_states
    @ca_master_1 = EmpireMasterList.where(source: 'CA').where(license_number: @ca_1).where.not(license_number: @ca_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number)
    @ca_master_2 = EmpireMasterList.where(source: 'CA').where(license_number: @ca_1).where.not(license_number: @ca_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number)
    @ny_master_1 = EmpireMasterList.where(source: 'NY').where(license_number: @ny_1).where.not(license_number: @ny_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number)
    @ny_master_2 = EmpireMasterList.where(source: 'NY').where(license_number: @ny_1).where.not(license_number: @ny_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number)
    @nm_master_1 = EmpireMasterList.where(source: 'NM').where(license_number: @nm_1).where.not(license_number: @nm_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @nm_master_2 = EmpireMasterList.where(source: 'NM').where(license_number: @nm_1).where.not(license_number: @nm_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @ut_master_1 = EmpireMasterList.where(source: 'UT').where(license_number: @ut_1).where.not(license_number: @ut_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @ut_master_2 = EmpireMasterList.where(source: 'UT').where(license_number: @ut_1).where.not(license_number: @ut_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @wa_master_1 = EmpireMasterList.where(source: 'WA').where(license_number: @wa_1).where.not(license_number: @wa_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number)#all NM That meet the date criteria, and match the first array but no the second
    @wa_master_2 = EmpireMasterList.where(source: 'WA').where(license_number: @wa_1).where.not(license_number: @wa_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second

    @exp_1 = @ca_master_1.count + @ny_master_1.count + @nm_master_1.count + @ut_master_1.count + @wa_master_1.count
    @exp_2 = @ca_master_2.count + @ny_master_2.count + @nm_master_2.count + @ut_master_2.count + @wa_master_2.count
    # @export_1 = @ca_master_1.union(@ca_master_2)
    # @export_1 = @ca_master_1.union(@ca_master_2).union(@ny_master_1).union(@ny_master_2).union(@nm_master_1).union(@nm_master_2).union(@ut_master_1).union(@ut_master_2).union(@wa_master_1).union(@wa_master_2)
    # @export_2 = EmpireCustomer.where(license_num: ca_export).where(lic_state: 'CA').all

    # @export = @ca_master_1.or(@ca_master_2).or(@ny_master_1).or(@ny_master_2).or(@nm_master_1).or(@nm_master_2).or(@ut_master_1).or(@ut_master_2).or(@wa_master_1).or(@wa_master_2)
    @empire_purchases = EmpireCustomer.all
    @empire_customers = EmpireCustomer.pluck(:uid).uniq

      if params['added'] == 'done'
        ### CA
        ca_export = @ca_master_1.union(@ca_master_2)
        ca_empire = EmpireCustomer.where(lic_state: 'CA').where(license_num: ca_export).all
        ca_license_number = []

        ca_empire.each do |empire_customer|
          if ca_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-#{params['day']}",
              mail_date: params['day'],
              state: 'CA',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            ca_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end

        ### NY
        ny_export = @ny_master_1.union(@ny_master_2)
        ny_empire = EmpireCustomer.where(lic_state: 'NY').where(license_num: ny_export).all
        ny_license_number = []

        ny_empire.each do |empire_customer|
          if ny_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-#{params['day']}",
              mail_date: params['day'],
              state: 'NY',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            ny_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end
        ### NM
        nm_export = @nm_master_1.union(@nm_master_2)
        nm_empire = EmpireCustomer.where(lic_state: 'NM').where(license_num: nm_export).all
        nm_license_number = []

        nm_empire.each do |empire_customer|
          if nm_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-#{params['day']}",
              mail_date: params['day'],
              state: 'NM',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            nm_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end
        ### UT
        ut_export = @ut_master_1.union(@ut_master_2)
        ut_empire = EmpireCustomer.where(lic_state: 'UT').where(license_num: ut_export).all
        ut_license_number = []

        ut_empire.each do |empire_customer|
          if ut_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-#{params['day']}",
              mail_date: params['day'],
              state: 'UT',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            ut_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end
        ### WA
        wa_export = @wa_master_1.union(@wa_master_2)
        wa_empire = EmpireCustomer.where(lic_state: 'WA').where(license_num: wa_export).all
        wa_license_number = []

        wa_empire.each do |empire_customer|
          if wa_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-#{params['day']}",
              mail_date: params['day'],
              state: 'WA',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            wa_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end



        redirect_to postcard_exports_path(mail_id: "E-RC-#{params['day']}", day: params['day'])

      end #If 'data'
  end

  def rc_marketing_date
      if params['day'].present?
        @mail_day = params['day'].to_date
        @date_1a = ((@mail_day + 33.days).to_date).at_beginning_of_week
        @date_1b = ((@mail_day + 33.days).to_date).at_end_of_week
        @date_2a = ((@mail_day + 63.days).to_date).at_beginning_of_week
        @date_2b = ((@mail_day + 63.days).to_date).at_end_of_week
      end
  end

  def rc_marketing_states

    #Monthly Expiration States
      ca = EmpireCustomer.where(lic_state: 'CA').all #All NM Customers
      @ca_1 = ca.pluck(:license_num).uniq #Array of all unique license numbers
      @ca_2 = ca.where('p_date >= ?', Date.today - 30.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      ny = EmpireCustomer.where(lic_state: 'NY').all #All NM Customers
      @ny_1 = ny.pluck(:license_num).uniq #Array of all unique license numbers
      @ny_2 = ny.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      nm = EmpireCustomer.where(lic_state: 'NM').all #All NM Customers
      @nm_1 = nm.pluck(:license_num).uniq #Array of all unique license numbers
      @nm_2 = nm.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      ut = EmpireCustomer.where(lic_state: 'UT').all #All NM Customers
      @ut_1 = ut.pluck(:license_num).uniq #Array of all unique license numbers
      @ut_2 = ut.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      wa = EmpireCustomer.where(lic_state: 'WA').all #All NM Customers
      @wa_1 = wa.pluck(:license_num).uniq #Array of all unique license numbers
      @wa_2 = wa.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame

  end

  def exports
    if params['page'] == 'pa_email'
      @renewal_year = '2020'
      @message = 'PA Return Customer Emails'
      @info = 'Removed users who have purchase in this renewal cycle. Removed Duplicates.'
      @show = EmpireCustomer.where(lic_state: 'PA').first(10)
      @title = 'PA_email'
      export_1 = EmpireCustomer.where(lic_state: 'PA').all
      pa_exclude = export_1.where('p_date > ?', '2018-06-01').pluck(:uid)
      @export_2 = export_1.where.not(uid: pa_exclude).all

      ids = []
      uid = []

      @export_2.each do |i|
        unless uid.include? i.uid
          ids.push(i.id)
          uid.push(i.uid)
        end
      end

      @export = @export_2.where(id: ids).all
    end

    respond_to do |format|
      format.html
      format.csv { send_data @export.to_csv, filename: "#{@title}_#{Date.today}.csv" }
    end

  end

  def sales

  end

  def run_data
    if params['e_id'].present?
      # if params['e_id'].to_i > EmpireCustomer.all.pluck(:e_id).max
          new = EmpireCustomer.create(
            e_id: params['e_id'].present? ? params['e_id'].to_i : 0,
            uid: params['uid'],
            license_num: params['license_num'],
            existing: params['existing'],
            p_date: params['purchase_date'].present? ? Date::strptime(params['purchase_date'],"%m/%d/%y") : '',
            purchase_date: params['purchase_date'],
            lic_state: params['lic_state'],
            products: params['products'],
            total: params['order_total'].present? ? params['order_total'].to_f : 0,
            order_total: params['order_total'],
            fname: params['fname'],
            lname: params['lname'],
            company: params['company'],
            street_1: params['street_1'],
            street_2: params['street_2'],
            city: params['city'],
            state: params['state'],
            zip: params['zip'],
            email: params['email'],
            phone: params['phone'])

          new.save

        redirect_to data_mailing_empire_nms_path
      # elsif
        # redirect_to empire_customers_path(done: 'YES')
      # end
    end
    # redirect_to empire_customers_path(done: 'YES')
  end

  # GET /empire_customers/1
  # GET /empire_customers/1.json
  def show
  end

  # GET /empire_customers/new
  def new
    @empire_customer = EmpireCustomer.new
  end

  # GET /empire_customers/1/edit
  def edit
  end

  # POST /empire_customers
  # POST /empire_customers.json
  def create
    @empire_customer = EmpireCustomer.new(empire_customer_params)

    respond_to do |format|
      if @empire_customer.save
        format.html { redirect_to @empire_customer, notice: 'Empire customer was successfully created.' }
        format.json { render :show, status: :created, location: @empire_customer }
      else
        format.html { render :new }
        format.json { render json: @empire_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_customers/1
  # PATCH/PUT /empire_customers/1.json
  def update
    respond_to do |format|
      if @empire_customer.update(empire_customer_params)
        format.html { redirect_to @empire_customer, notice: 'Empire customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_customer }
      else
        format.html { render :edit }
        format.json { render json: @empire_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_customers/1
  # DELETE /empire_customers/1.json
  def destroy
    @empire_customer.destroy
    respond_to do |format|
      format.html { redirect_to empire_customers_url, notice: 'Empire customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    EmpireCustomer.my_import(params[:file])
    redirect_to empire_customers_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_customer
      @empire_customer = EmpireCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_customer_params
      params.require(:empire_customer).permit(:e_id, :uid, :license_num, :existing, :purchase_date, :lic_state, :products, :order_total, :fname, :lname, :company, :street_1, :street_2, :city, :state, :zip, :email, :phone, :p_date, :total)
    end
end
