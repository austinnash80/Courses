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
