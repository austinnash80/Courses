class DatasheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_datasheet, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction #sortable header columns

  # GET /datasheets
  # GET /datasheets.json
  def index
    @datasheets = Datasheet.order(sort_column + " " + sort_direction) #sortable header columns
    @datasheet_all = Datasheet.all

    respond_to do |format|
      format.html
      format.csv { send_data @datasheets.to_csv, filename: "datasheet-#{Date.today}.csv" }
    end
    course_counter
  end

  # GET /datasheets/1
  # GET /datasheets/1.json
  def show
    old_version_pub_dates
  end

  # GET /datasheets/new
  def new
    @datasheet = Datasheet.new
  end

  # GET /datasheets/1/edit
  def edit
  end

  # POST /datasheets
  # POST /datasheets.json
  def create
    @datasheet = Datasheet.new(datasheet_params)

    respond_to do |format|
      if @datasheet.save
        format.html { redirect_to @datasheet, notice: 'Datasheet was successfully created.' }
        format.json { render :show, status: :created, location: @datasheet }
      else
        format.html { render :new }
        format.json { render json: @datasheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datasheets/1
  # PATCH/PUT /datasheets/1.json
  def update
    respond_to do |format|
      if @datasheet.update(datasheet_params)
        format.html { redirect_to @datasheet, notice: 'Datasheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @datasheet }
      else
        format.html { render :edit }
        format.json { render json: @datasheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datasheets/1
  # DELETE /datasheets/1.json
  def destroy
    @datasheet.destroy
    respond_to do |format|
      format.html { redirect_to datasheets_url, notice: 'Datasheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    Datasheet.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to datasheets_path
  end

  def import #Uploading CSV function
    Datasheet.import(params[:file])
    redirect_to datasheets_path, notice: "Upload Complete"
  end

  def course_counter

    @active_courses = []
    @active_courses_ethics = []

    @datasheet_all.each do |datasheet|
      datasheet.active == true && datasheet.seq_number < 9000 ? @active_courses.push(datasheet['seq_number']) : ''
      datasheet.active == true && datasheet.seq_number >= 9000 ? @active_courses_ethics.push(datasheet['seq_number']) : ''
    end
  end

  def old_version_pub_dates

    @array = []

    if @datasheet.version_a.blank? == false
      # @datasheet.seq_version > 'A' ? @array.push((@datasheet.pub_date - @datasheet.version_a).to_i) : ''
       @datasheet.seq_version > 'B' ? @array.push((@datasheet.version_b - @datasheet.version_a).to_i) : ''
       @datasheet.seq_version > 'C' ? @array.push((@datasheet.version_c - @datasheet.version_b).to_i) : ''
       @datasheet.seq_version > 'D' ? @array.push((@datasheet.version_d - @datasheet.version_c).to_i) : ''
       @datasheet.seq_version > 'E' ? @array.push((@datasheet.version_e - @datasheet.version_d).to_i) : ''
       @datasheet.seq_version > 'F' ? @array.push((@datasheet.version_f - @datasheet.version_e).to_i) : ''
       @datasheet.seq_version > 'G' ? @array.push((@datasheet.version_g - @datasheet.version_f).to_i) : ''
       @datasheet.seq_version > 'H' ? @array.push((@datasheet.version_h - @datasheet.version_g).to_i) : ''
       @datasheet.seq_version > 'I' ? @array.push((@datasheet.version_i - @datasheet.version_h).to_i) : ''
       @datasheet.seq_version > 'J' ? @array.push((@datasheet.version_j - @datasheet.version_i).to_i) : ''
       @datasheet.seq_version > 'K' ? @array.push((@datasheet.version_k - @datasheet.version_j).to_i) : ''
       @datasheet.seq_version > 'L' ? @array.push((@datasheet.version_l - @datasheet.version_k).to_i) : ''
       @datasheet.seq_version > 'M' ? @array.push((@datasheet.version_m - @datasheet.version_l).to_i) : ''
       @datasheet.seq_version > 'N' ? @array.push((@datasheet.version_n - @datasheet.version_m).to_i) : ''
       @array.length > 0 ? @time_between = @array.sum / @array.length : 'nil'
     end
     
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datasheet
      @datasheet = Datasheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datasheet_params
      params.require(:datasheet).permit(:seq_number, :seq_version, :category, :seq_title, :hours, :pub_date, :seq_update, :seq_original_list, :active, :drop_date, :drop_reason, :pes_number, :pes_version, :pes_listed, :needs_approval, :has_approval, :approval_info, :course_note, :extra_note, :extra_boolean, :extra_integer, :version_0, :version_a, :version_b, :version_c, :version_d, :version_e, :version_f, :version_g, :version_h, :version_i, :version_j, :version_k, :version_l, :version_m, :version_n)
    end

    def sort_column # inline header sort function
      params[:sort] || 'seq_number'
    end

    def sort_direction # inline header sort function
      params[:direction] || 'asc'
    end

end
