class CpeDueDatesController < ApplicationController
  before_action :set_cpe_due_date, only: [:show, :edit, :update, :destroy]

  # GET /cpe_due_dates
  # GET /cpe_due_dates.json
  def index
    @cpe_due_dates = CpeDueDate.all.order(:state)
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
