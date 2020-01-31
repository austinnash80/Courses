class SCustomersController < ApplicationController
  before_action :set_s_customer, only: [:show, :edit, :update, :destroy]

  # GET /s_customers
  # GET /s_customers.json
  def index
    run_data

    @s_customers = SCustomer.all
    # @last_update = ['2019-01-01']
    @last_update = SCustomer.last(1).pluck(:purchase)
    @total_purchases = SCustomer.all.count
    customers = SCustomer.all.pluck(:uid)
    @unique_customers = customers.uniq.count
    @unique_states = 0
  end

  def run_data
    if params['s_id'].present?
        new = SCustomer.create(
          s_id: params['s_id'].present? ? params['s_id'].to_i : 0,
          order_id: params['order_id'],
          uid: params['uid'],
          existing: params['existing'],
          purchase_s: params['purchase'],
          purchase: params['purchase'].present? ? Date::strptime(params['purchase'],"%m/%d/%y") : '',
          product_1: params['product_1'],
          product_2: params['product_2'],
          designation: params['designation'],
          fname: params['fname'],
          lname: params['lname'],
          street_1: params['street_1'],
          street_2: params['street_2'],
          city: params['city'],
          state: params['state'],
          zip: params['zip'],
          email: params['email'],
          price_s: params['price'],
          price: params['price'].present? ? ((params['price'].to_f) * 100) : 0,
          lic_num: params['lic_num'],
          lic_state: params['lic_state'])

        new.save

      redirect_to data_s_customers_path
    end
  end

  def rc_marketing

  if params['day'].present?
      mail_date = params['day'].to_date

      if mail_date.strftime('%a') == 'Tue'
        @cpa_nm_date_a = mail_date - 4.day
        @cpa_nm_date_b = mail_date - 1.days
        @ea_nm_date_a = mail_date - 4.day
        @ea_nm_date_b = mail_date - 1.days
        @cpa_rc_date_a = mail_date + 7.day - 1.year
        @cpa_rc_date_b = mail_date + 9.days - 1.year
        @ea_rc_date_a = mail_date + 7.day - 1.year
        @ea_rc_date_b = mail_date + 9.days - 1.year
      else mail_date.strftime('%a') == 'Fri'
        @cpa_nm_date_a = mail_date - 3.day
        @cpa_nm_date_b = mail_date - 1.days
        @ea_nm_date_a = mail_date - 3.day
        @ea_nm_date_b = mail_date - 1.days
        @cpa_rc_date_a = mail_date + 7.day - 1.year
        @cpa_rc_date_b = mail_date + 10.days - 1.year
        @ea_rc_date_a = mail_date + 7.day - 1.year
        @ea_rc_date_b = mail_date + 10.days - 1.year
      end


      all_ea_membership = ["Unlimited EA CPE Membership", "Unlimited EA CE Membership", "1-Year EA Membership Renewal",  "1-Year EA Membership Discounted Re-Activation", "Unlimited EA Membership (Auto-Renew)", "1-Year EA Membership Re-Activation", "1-Year EA Membership Renewal (Auto-Renew)"]
      ea_membership = ["Unlimited EA CPE Membership", "Unlimited EA CE Membership", "1-Year EA Membership Renewal",  "1-Year EA Membership Discounted Re-Activation", "1-Year EA Membership Re-Activation"]

      all_cpa_membership = ["1-Year CPA Membership Discounted Re-Activation", "1-Year CPA Membership Re-Activation", "1-Year CPA Membership Renewal", "1-Year CPA Membership Renewal (Auto-Renew)", "Unlimited CPA CPE Membership", "Unlimited CPA CPE Membership (Auto-Renew)", "Unlimited EA CE Membership", "Unlimited EA CPE Membership", "Unlimited EA Membership (Auto-Renew)"]
      cpa_membership = ["1-Year CPA Membership Discounted Re-Activation", "1-Year CPA Membership Re-Activation", "1-Year CPA Membership Renewal", "Unlimited CPA CPE Membership", "Unlimited EA CE Membership", "Unlimited EA CPE Membership"]
      # cpa_membership does not include auto-renew memberships
      cpa_purchased_in_this_cycle = SCustomer.where('purchase >= ?', mail_date - 9.months).where(product_1: cpa_membership).pluck(:uid)
      ea_purchased_in_this_cycle = SCustomer.where('purchase >= ?', mail_date - 9.months).where(product_1: ea_membership).pluck(:uid)

      @cpa_nm_records = SCustomer.where('purchase >= ? AND purchase <= ?', @cpa_nm_date_a, @cpa_nm_date_b ).where(product_1: cpa_membership).all
      @cpa_rc_records = SCustomer.where('purchase >= ? AND purchase <= ?', @cpa_rc_date_a, @cpa_rc_date_b ).where(product_1: cpa_membership).where.not(uid: cpa_purchased_in_this_cycle).all
      @ea_nm_records = SCustomer.where('purchase >= ? AND purchase <= ?', @ea_nm_date_a, @ea_nm_date_b ).where(product_1: ea_membership).all
      @ea_rc_records = SCustomer.where('purchase >= ? AND purchase <= ?', @ea_rc_date_a, @ea_rc_date_b ).where(product_1: ea_membership).where.not(uid: ea_purchased_in_this_cycle).all
    end

    if params['added'] == 'done'

      PostcardExport.delete_all #Delete all the current records - fresh database each time.

      if params['group'] == 'CPA-NM'
        group = @cpa_nm_records
      elsif params['group'] == 'CPA-RC'
        group = @cpa_rc_records
      elsif params['group'] == 'EA-NM'
        group = @ea_nm_records
      elsif params['group'] == 'EA-RC'
        group = @ea_rc_records
      end

      uid = []

      group.each do |s_customer|
      if uid.exclude? s_customer.uid
        new = PostcardExport.create(
          company: params['co'],
          group: params['group'],
          mail_id: "S-#{params['group']}-Postcard-#{params['day']}",
          mail_date: params['day'],
          state: params['st'],
          license_number: 'na',
          uid: s_customer.uid,
          merge_1: s_customer.purchase,
          merge_2: s_customer.product_1,
          merge_3: 'Merge Text 1',
          f_name: s_customer.fname,
          l_name: s_customer.lname,
          add_1: s_customer.street_1,
          add_2: s_customer.street_2,
          city: s_customer.city,
          st: s_customer.state,
          zip: s_customer.zip,
          email: s_customer.email)
        new.save
        uid.push(s_customer.uid) #Push new records lic number in to array to not allow duplicates in new table
      end
      end
    redirect_to postcard_exports_path(co: params['co'], group: params['group'], mail_id: "S-#{params['group']}-Postcard-#{params['day']}", day: params['day'], card: 'postcard standard', sent: group.count)
    end
  end

  def data
    @id = SCustomer.pluck(:s_id).max
  end

  def import

    SCustomer.my_import(params[:file])
    redirect_to s_customers_path, notice: "upload Complete"
  end

  # GET /s_customers/1
  # GET /s_customers/1.json
  def show
  end

  # GET /s_customers/new
  def new
    @s_customer = SCustomer.new
  end

  # GET /s_customers/1/edit
  def edit
  end

  # POST /s_customers
  # POST /s_customers.json
  def create
    @s_customer = SCustomer.new(s_customer_params)

    respond_to do |format|
      if @s_customer.save
        format.html { redirect_to @s_customer, notice: 'S customer was successfully created.' }
        format.json { render :show, status: :created, location: @s_customer }
      else
        format.html { render :new }
        format.json { render json: @s_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_customers/1
  # PATCH/PUT /s_customers/1.json
  def update
    respond_to do |format|
      if @s_customer.update(s_customer_params)
        format.html { redirect_to @s_customer, notice: 'S customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @s_customer }
      else
        format.html { render :edit }
        format.json { render json: @s_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_customers/1
  # DELETE /s_customers/1.json
  def destroy
    @s_customer.destroy
    respond_to do |format|
      format.html { redirect_to s_customers_url, notice: 'S customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_customer
      @s_customer = SCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_customer_params
      params.require(:s_customer).permit(:s_id, :order_id, :uid, :existing, :purchase_s, :purchase, :product_1, :product_2, :designation, :fname, :lname, :street_1, :street_2, :city, :state, :zip, :email, :price_s, :price, :lic_num, :lic_state, :total)
    end
end
