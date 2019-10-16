class PesCoursesController < ApplicationController
  before_action :set_pes_course, only: [:show, :edit, :update, :destroy, :change]

  # GET /pes_courses
  # GET /pes_courses.json

  def index
    @pes_courses = PesCourse.order('active DESC').order(:pes_number)
    @date_fields = DateField.all

    respond_to do |format|
      format.html
      format.csv { send_data @pes_courses.to_csv, filename: "pes_course-#{Date.today}.csv" }
    end

    course_counter

  end

  # GET /pes_courses/1
  # GET /pes_courses/1.json
  def show
  end

  # GET /pes_courses/new
  def new
    @pes_course = PesCourse.new
    form_collections
  end

  # GET /pes_courses/1/edit
  def edit
    form_collections
  end

  # POST /pes_courses
  # POST /pes_courses.json
  def create
    @pes_course = PesCourse.new(pes_course_params)

    respond_to do |format|
      if @pes_course.save
        format.html { redirect_to @pes_course, notice: 'Pes course was successfully created.' }
        format.json { render :show, status: :created, location: @pes_course }
      else
        format.html { render :new }
        format.json { render json: @pes_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pes_courses/1
  # PATCH/PUT /pes_courses/1.json
  def update
    respond_to do |format|
      if @pes_course.update(pes_course_params)
        format.html { redirect_to @pes_course, notice: 'Pes course was successfully updated.' }
        format.json { render :show, status: :ok, location: @pes_course }
      else
        format.html { render :edit }
        format.json { render json: @pes_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pes_courses/1
  # DELETE /pes_courses/1.json
  def destroy
    @pes_course.destroy
    respond_to do |format|
      format.html { redirect_to pes_courses_url, notice: 'Pes course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    PesCourse.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to pes_courses_path
  end

  def import #Uploading CSV function
    PesCourse.import(params[:file])
    redirect_to pes_courses_path, notice: "Upload Complete"
  end

  def form_collections
    @course_tags = ['N/A', 'New', 'Top Seller', 'Hot Topic', 'Popular']
    @course_cat = ['Accounting', 'Auditing', 'Taxes', 'Management Services', 'Business Law', 'Business Management', 'Communications', 'Computer Applications', 'Finance', 'Personnel/Human Resources', 'Ethics']
  end

  def course_counter
    @active_pes_courses = PesCourse.where('active = true').count
    @inactive_pes_courses = PesCourse.where('active = false').count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pes_course
      @pes_course = PesCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pes_course_params
      params.require(:pes_course).permit(:pes_number, :category, :hours, :active, :title, :tag, :date_added, :date_removed, :extra_s, :extra_i, :extra_b, :extra_d)
    end
end
