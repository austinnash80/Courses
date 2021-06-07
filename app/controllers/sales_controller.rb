class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
    @sales_display = Sale.order('day DESC').all
    @sales_enter = Sale.order('day ASC').all

    @week_b = Date.today.at_beginning_of_week - 64.days
    @week_e = Date.today.at_end_of_week
    @dates = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:day)


    @sales_seq = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').all
    # @sales_seq = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:sequoia)
    @test = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:day)

    #DAYS of the WEEK
    @mon = []
    @tue = []
    @wed = []
    @thu = []
    @fri = []
    @sat = []
    @sun = []
    @sales_seq.each do |i|
      i.day.wday == 1 ? @mon.push(i.sequoia) : ''
      i.day.wday == 2 ? @tue.push(i.sequoia) : ''
      i.day.wday == 3 ? @wed.push(i.sequoia) : ''
      i.day.wday == 4 ? @thu.push(i.sequoia) : ''
      i.day.wday == 5 ? @fri.push(i.sequoia) : ''
      i.day.wday == 6 ? @sat.push(i.sequoia) : ''
      i.day.wday == 0 ? @sun.push(i.sequoia) : ''
    end

# EXPORT
    respond_to do |format|
      format.html
      format.csv { send_data @sales.to_csv, filename: "sales-#{Date.today}.csv" }
    end
#EXPORT
year_change
table_2
  end

  def year_change
    @week_b_year = (Date.today.at_beginning_of_week - 64.days)
    @week_e_year = (Date.today.at_end_of_week)
    @sales_seq_year = Sale.where('day > ?', @week_b_year).where('day < ?', @week_e_year + 1.day).order('day ASC').all

    @weeks = []
    @sales_seq_year.each do |i|
      @weeks.push(i.sequoia)
    end
  end

  def table_2

    @week_b_2 = (((Date.today - 128.days).at_beginning_of_week) - 1.day)
    @week_e_2 = (((Date.today - 67.days).at_end_of_week) + 1.day)
    @dates_2 = Sale.where('day > ?', @week_b_2).where('day < ?', @week_e_2).order('day ASC').pluck(:day)


    @sales_seq_2 = Sale.where('day > ?', @week_b_2).where('day < ?', @week_e_2).order('day ASC').all
    # @sales_seq = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:sequoia)
    # @test = Sale.where('day > ?', @week_b).where('day < ?', @week_e + 1.day).order('day ASC').pluck(:day)

    #DAYS of the WEEK
    @mon_2 = []
    @tue_2 = []
    @wed_2 = []
    @thu_2 = []
    @fri_2 = []
    @sat_2 = []
    @sun_2 = []
    @sales_seq_2.each do |i|
      i.day.wday == 1 ? @mon_2.push(i.sequoia) : ''
      i.day.wday == 2 ? @tue_2.push(i.sequoia) : ''
      i.day.wday == 3 ? @wed_2.push(i.sequoia) : ''
      i.day.wday == 4 ? @thu_2.push(i.sequoia) : ''
      i.day.wday == 5 ? @fri_2.push(i.sequoia) : ''
      i.day.wday == 6 ? @sat_2.push(i.sequoia) : ''
      i.day.wday == 0 ? @sun_2.push(i.sequoia) : ''
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
