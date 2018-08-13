class SeqCustomersController < ApplicationController
  before_action :set_seq_customer, only: [:show, :edit, :update, :destroy]

  # GET /seq_customers
  # GET /seq_customers.json
  def index
    @seq_customers = SeqCustomer.last(15)
  end

  # GET /seq_customers/1
  # GET /seq_customers/1.json
  def show
  end

  # GET /seq_customers/new
  def new
    @seq_customer = SeqCustomer.new
  end

  # GET /seq_customers/1/edit
  def edit
  end

  # POST /seq_customers
  # POST /seq_customers.json
  def create
    @seq_customer = SeqCustomer.new(seq_customer_params)

    respond_to do |format|
      if @seq_customer.save
        format.html { redirect_to @seq_customer, notice: 'Seq customer was successfully created.' }
        format.json { render :show, status: :created, location: @seq_customer }
      else
        format.html { render :new }
        format.json { render json: @seq_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seq_customers/1
  # PATCH/PUT /seq_customers/1.json
  def update
    respond_to do |format|
      if @seq_customer.update(seq_customer_params)
        format.html { redirect_to @seq_customer, notice: 'Seq customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @seq_customer }
      else
        format.html { render :edit }
        format.json { render json: @seq_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seq_customers/1
  # DELETE /seq_customers/1.json
  def destroy
    @seq_customer.destroy
    respond_to do |format|
      format.html { redirect_to seq_customers_url, notice: 'Seq customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    SeqCustomer.import(params[:file])
    redirect_to seq_customers_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seq_customer
      @seq_customer = SeqCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seq_customer_params
      params.require(:seq_customer).permit(:order_id, :uid, :purchase, :product_1, :product_2, :designation, :fname, :lname, :street_1, :street_2, :city, :state, :zip, :email, :price_2, :lic_num)
    end
end
