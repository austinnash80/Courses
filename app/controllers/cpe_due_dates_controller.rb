class CpeDueDatesController < ApplicationController
  before_action :set_cpe_due_date, only: [:show, :edit, :update, :destroy]

  # GET /cpe_due_dates
  # GET /cpe_due_dates.json
  def index
    @cpe_due_dates = CpeDueDate.all.order(:state)
    totals
  end

  def totals

    @monthly_all = CpeDueDate.where('cpe_due' => '0', 'exclude' => false, 'extra_b' => true ).sum(:quanity)
    @month_6_all = CpeDueDate.where('cpe_due' => '6', 'exclude' => false, 'extra_b' => true ).sum(:quanity)
    @month_12_all = CpeDueDate.where('cpe_due' => '12', 'exclude' => false, 'extra_b' => true ).sum(:quanity)
    @month_other_all = CpeDueDate.where('exclude' => false, 'extra_b' => true ).where('cpe_due=? OR cpe_due=?', '7', '9').sum(:quanity)

    @partials_12 = []
    @partials_6 = []
    @partials_0 = []

    @cpe_due_dates.each do |cpe_due_date|
      if cpe_due_date.cpe_due == '12' && cpe_due_date.exclude == false && cpe_due_date.partial_number.blank? == false
        @partials_12.push(cpe_due_date['partial_number'].to_f * cpe_due_date['quanity'])
      end
      if cpe_due_date.cpe_due == '6' && cpe_due_date.exclude == false && cpe_due_date.partial_number.blank? == false
        @partials_6.push(cpe_due_date['partial_number'].to_f * cpe_due_date['quanity'])
      end
      if cpe_due_date.cpe_due == '0' && cpe_due_date.exclude == false && cpe_due_date.partial_number.blank? == false
        @partials_0.push(cpe_due_date['partial_number'].to_f * cpe_due_date['quanity'])
      end
    end

    @total = @monthly_all + @month_6_all + @month_12_all + @month_other_all + @partials_12.sum + @partials_6.sum + @partials_0.sum

  end

  # GET /cpe_due_dates/1
  # GET /cpe_due_dates/1.json
  def show
  end

  # GET /cpe_due_dates/new
  def new
    @cpe_due_date = CpeDueDate.new
  end

  # GET /cpe_due_dates/1/edit
  def edit
  end

  # POST /cpe_due_dates
  # POST /cpe_due_dates.json
  def create
    @cpe_due_date = CpeDueDate.new(cpe_due_date_params)

    respond_to do |format|
      if @cpe_due_date.save
        format.html { redirect_to @cpe_due_date, notice: 'Cpe due date was successfully created.' }
        format.json { render :show, status: :created, location: @cpe_due_date }
      else
        format.html { render :new }
        format.json { render json: @cpe_due_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpe_due_dates/1
  # PATCH/PUT /cpe_due_dates/1.json
  def update
    respond_to do |format|
      if @cpe_due_date.update(cpe_due_date_params)
        format.html { redirect_to @cpe_due_date, notice: 'Cpe due date was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpe_due_date }
      else
        format.html { render :edit }
        format.json { render json: @cpe_due_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpe_due_dates/1
  # DELETE /cpe_due_dates/1.json
  def destroy
    @cpe_due_date.destroy
    respond_to do |format|
      format.html { redirect_to cpe_due_dates_url, notice: 'Cpe due date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    CpeDueDate.import(params[:file])
    redirect_to cpe_due_dates_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpe_due_date
      @cpe_due_date = CpeDueDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpe_due_date_params
      params.require(:cpe_due_date).permit(:state, :st, :quanity, :cpe_group, :renew_type, :cpe_due, :ss_allowed, :year_minimum, :exclude, :state_note, :partial_mail, :partial_number, :extra_s, :extra_b, :extra_i, :extra_d)
    end
end
