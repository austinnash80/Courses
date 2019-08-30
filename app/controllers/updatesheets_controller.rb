class UpdatesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_updatesheet, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction #Sortable column headers

  # GET /updatesheets
  # GET /updatesheets.json
  def index
    @updatesheets = Updatesheet.order(sort_column + " " + sort_direction)
  end

  # GET /updatesheets/1
  # GET /updatesheets/1.json
  def show
  end

  # GET /updatesheets/new
  def new
    @updatesheet = Updatesheet.new
  end

  # GET /updatesheets/1/edit
  def edit
  end

  # POST /updatesheets
  # POST /updatesheets.json
  def create
    @updatesheet = Updatesheet.new(updatesheet_params)

    respond_to do |format|
      if @updatesheet.save
        format.html { redirect_to updatesheets_path, notice: 'Updatesheet was successfully created.' }
        format.json { render :show, status: :created, location: @updatesheet }
      else
        format.html { render :new }
        format.json { render json: @updatesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updatesheets/1
  # PATCH/PUT /updatesheets/1.json
  def update
    respond_to do |format|
      if @updatesheet.update(updatesheet_params)
        if @updatesheet.update_datasheet?
        # if @updatesheet.text_complete? && @updatesheet.exam_complete? && @updatesheet.course_listed?
          # format.html { redirect_to edit_datasheet_path(id: @updatesheet.seq_number, update: 'yes', seq_version: @updatesheet.seq_version, pes_version: @updatesheet.pes_version, pub_date: @updatesheet.pub_date) , notice: 'Updatesheet was successfully updated.' }

            old_pub_dates
            Datasheet.where(seq_number: @updatesheet.seq_number).update_all seq_version: @updatesheet.seq_version, pes_version: @updatesheet.pes_version, pub_date: @updatesheet.pub_date, seq_update: Date.today

          format.html { redirect_to updatesheets_path, notice: 'Course Datasheet and Updatesheet were successfully updated.' }
          format.json { render :show, status: :ok, location: @updatesheet }
        elsif
          format.html { redirect_to updatesheets_path(test: 'yes') , notice: 'Updatesheet was successfully updated.' }
          format.json { render :show, status: :ok, location: @updatesheet }
        end

      else
        format.html { render :edit }
        format.json { render json: @updatesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /updatesheets/1
  # DELETE /updatesheets/1.json
  def destroy
    @updatesheet.destroy
    respond_to do |format|
      format.html { redirect_to updatesheets_url, notice: 'Updatesheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def old_pub_dates
    if @updatesheet.seq_version == 'B'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_a: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'C'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_b: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'D'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_c: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'E'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_d: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'F'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_e: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'G'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_f: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'H'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_g: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'I'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_h: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'J'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_i: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'K'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_j: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'L'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_k: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'M'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_l: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'N'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_m: @updatesheet.datasheet.pub_date
    elsif @updatesheet.seq_version == 'O'
      Datasheet.where(seq_number: @updatesheet.seq_number).update_all version_n: @updatesheet.datasheet.pub_date
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_updatesheet
      @updatesheet = Updatesheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def updatesheet_params
      params.require(:updatesheet).permit(:pes_number, :pes_version, :date_received, :update_course, :note_approval, :text_complete, :exam_complete, :course_listed, :date_listed, :role, :rolep, :irs_number, :proofed, :proofed_note, :datasheet_id, :seq_number, :seq_version, :seq_title, :extra_string, :extra_integer, :extra_boolean, :pub_date, :update_datasheet, :extra_d)

    end

    #sortable column headers - set the default
    def sort_column
      params[:sort] || 'date_received' || 'seq_number'
    end

    def sort_direction
      params[:direction] || 'desc'
    end
end
