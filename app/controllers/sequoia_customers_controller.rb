class SequoiaCustomersController < ApplicationController
  before_action :set_sequoia_customer, only: [:show, :edit, :update, :destroy]

  # GET /sequoia_customers
  # GET /sequoia_customers.json
  def index
    @sequoia_customers = SequoiaCustomer.order(:purchase_date => :desc).first(25)
    @sequoia_customers_all = SequoiaCustomer.all

    @total = []

    @total_records = SequoiaCustomer.count(:uid)
    @newest_record = SequoiaCustomer.pluck(:purchase_date).max
    # @sequoia_customers_all.each do |i|
    #   @total.push(i['Uid'])
    # end
    # @totalL = @total.length
    #
    # @date_ary = []
    # @sequoia_customers_all.each do |i|
    #   @date_ary.push(i['purchase_date'])
    # end
    # @recent_date = @date_ary.max
  end

  # GET /sequoia_customers/1
  # GET /sequoia_customers/1.json
  def show
  end

  # GET /sequoia_customers/new
  def new
    @sequoia_customer = SequoiaCustomer.new
  end

  # GET /sequoia_customers/1/edit
  def edit
  end

  # POST /sequoia_customers
  # POST /sequoia_customers.json
  def create
    @sequoia_customer = SequoiaCustomer.new(sequoia_customer_params)

    respond_to do |format|
      if @sequoia_customer.save
        format.html { redirect_to @sequoia_customer, notice: 'Sequoia customer was successfully created.' }
        format.json { render :show, status: :created, location: @sequoia_customer }
      else
        format.html { render :new }
        format.json { render json: @sequoia_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequoia_customers/1
  # PATCH/PUT /sequoia_customers/1.json
  def update
    respond_to do |format|
      if @sequoia_customer.update(sequoia_customer_params)
        format.html { redirect_to @sequoia_customer, notice: 'Sequoia customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @sequoia_customer }
      else
        format.html { render :edit }
        format.json { render json: @sequoia_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequoia_customers/1
  # DELETE /sequoia_customers/1.json
  def destroy
    @sequoia_customer.destroy
    respond_to do |format|
      format.html { redirect_to sequoia_customers_url, notice: 'Sequoia customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    SequoiaCustomer.where('purchase_date > ?', '2018-09-30').delete_all
    flash[:notice] = "All Records Removed"
    redirect_to sequoia_customers_path
  end

  def import
    SequoiaCustomer.my_import(params[:file])
    redirect_to sequoia_customers_path, notice: "upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequoia_customer
      @sequoia_customer = SequoiaCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequoia_customer_params
      params.require(:sequoia_customer).permit(:unique_id, :order_id, :uid, :purchase_date, :product, :who, :what, :hours, :price, :fname, :lname, :street_1, :street_2, :city, :state, :state, :zip, :email, :lic_num)
    end
end
