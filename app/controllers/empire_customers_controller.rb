class EmpireCustomersController < ApplicationController
  # before_action :all_empire_customers, only: [:index, :create]
  before_action :set_empire_customer, only: [:show, :edit, :update, :destroy]
  # respond_to :html, :js

  # GET /empire_customers
  # GET /empire_customers.json
  def index
    @empire_customers_count = EmpireCustomer.all.count
    @empire_customers = EmpireCustomer.order(:e_id).last(1)
    @uids = EmpireCustomer.pluck(:uid)
    @id = '3'
    # if params['fname'].present?
    if params['e_id'].present?
      # if @uids.exclude?(params['uid'])
        new = EmpireCustomer.create(e_id: params['e_id'].to_i, uid: params['uid'], license_num: params['license_num'], existing: params['existing'], p_date: Date::strptime(params['purchase_date'],"%m/%d/%y"), purchase_date: params['purchase_date'], lic_state: params['lic_state'], products: params['products'], total: params['order_total'].to_f, order_total: params['order_total'], fname: params['fname'], lname: params['lname'], company: params['company'], street_1: params['street_1'], street_2: params['street_2'], city: params['city'], state: params['state'], zip: params['zip'], email: params['email'], phone: params['phone'])
        new.save
      # end
      redirect_to data_mailing_empire_nms_path
    end
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
