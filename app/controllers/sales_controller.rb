class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
    @sales_display = Sale.order('day DESC').all
    @sales_enter = Sale.order('day ASC').all

    @week_b = Date.today.at_beginning_of_week - 64.day
    @week_e = Date.today.at_end_of_week
    @dates = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:day)


    @sales_seq = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:sequoia)

    #DAYS of the WEEK
    @mon = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 7 == 0}
    @tue = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 8 == 0}
    @wed = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 9 == 0}
    @thu = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 10 == 0}
    @fri = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 11 == 0}
    @sat = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 12 == 0}
    @sun = @sales_seq.select { |x| (@sales_seq.index(x) + 7) % 13 == 0}

    respond_to do |format|
      format.html
      format.csv { send_data @sales.to_csv, filename: "sales-#{Date.today}.csv" }
    end

  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sequoia_dash_path, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    Sale.my_import(params[:file])
    redirect_to sales_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:day, :sequoia, :empire, :pacific, :extra_d, :extra_s, :extra_b)
    end
end
