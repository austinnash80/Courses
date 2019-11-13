class SCustomersController < ApplicationController
  before_action :set_s_customer, only: [:show, :edit, :update, :destroy]

  # GET /s_customers
  # GET /s_customers.json
  def index
    run_data
    @s_customers = SCustomer.all
    @last_update = ['2019-01-01']
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
          price: params['price'].present? ? params['price'].to_f : 0,
          lic_num: params['lic_num'],
          lic_state: params['lic_state'])

        new.save

      redirect_to sequoia_s_data_path
    end
  end

  def data
    @id = SCustomer.pluck(:s_id).max
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
      params.require(:s_customer).permit(:s_id, :order_id, :uid, :existing, :purchase_s, :purchase, :product_1, :product_2, :designation, :fname, :lname, :street_1, :street_2, :city, :state, :zip, :email, :price_s, :price, :lic_num, :lic_state)
    end
end
