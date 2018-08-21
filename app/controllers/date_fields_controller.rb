class DateFieldsController < ApplicationController
  before_action :set_date_field, only: [:show, :edit, :update, :destroy]

  # GET /date_fields
  # GET /date_fields.json
  def index
    @date_fields = DateField.all
  end

  # GET /date_fields/1
  # GET /date_fields/1.json
  def show
  end

  # GET /date_fields/new
  def new
    @date_field = DateField.new
  end

  # GET /date_fields/1/edit
  def edit
  end

  # POST /date_fields
  # POST /date_fields.json
  def create
    @date_field = DateField.new(date_field_params)

    respond_to do |format|
      if @date_field.save
        format.html { redirect_to @date_field, notice: 'Date field was successfully created.' }
        format.json { render :show, status: :created, location: @date_field }
      else
        format.html { render :new }
        format.json { render json: @date_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /date_fields/1
  # PATCH/PUT /date_fields/1.json
  def update
    respond_to do |format|
      if @date_field.update(date_field_params)
        format.html { redirect_to @date_field, notice: 'Date field was successfully updated.' }
        format.json { render :show, status: :ok, location: @date_field }
      else
        format.html { render :edit }
        format.json { render json: @date_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /date_fields/1
  # DELETE /date_fields/1.json
  def destroy
    @date_field.destroy
    respond_to do |format|
      format.html { redirect_to date_fields_url, notice: 'Date field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_field
      @date_field = DateField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def date_field_params
      params.require(:date_field).permit(:date1, :date2, :date3, :date4)
    end
end
