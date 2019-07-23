class EmpireCoursesController < ApplicationController
  before_action :set_empire_course, only: [:show, :edit, :update, :destroy]

  # GET /empire_courses
  # GET /empire_courses.json
  def index
    @empire_courses = EmpireCourse.order(:id).all
    @course_creation_tasks = CourseCreationTask.all
  end

  # GET /empire_courses/1
  # GET /empire_courses/1.json
  def show
    @course_creation_tasks = CourseCreationTask.order(:extra_i).all
    @course_creation_tasks_ip = CourseCreationTask.includes(:course_creation_templete).order('course_creation_templetes.extra_i ASC').all
    @course_creation_tasks_c = CourseCreationTask.includes(:course_creation_templete).order('course_creation_templetes.extra_i ASC').all
    # User.joins(:user_extension).merge(UserExtension.order(company: :desc))
    @course_creation_templetes = CourseCreationTemplete.order(:extra_i).all
    # @course_creation_templetes = CourseCreationTemplete.where(@empire_course.extra_s => :extra_s).order(:id).all

    @created = []
    @completed_tasks = []
    @inprogress_tasks = []

    @course_creation_tasks.each do |course_creation_task|
      course_creation_task.empire_course_id == @empire_course.id ? @created.push(course_creation_task.course_creation_templete.id) : ''
      course_creation_task.empire_course_id == @empire_course.id && course_creation_task.extra_s == 'Complete' ? @completed_tasks.push(1) : ''
      course_creation_task.empire_course_id == @empire_course.id && course_creation_task.extra_s != 'Complete' ? @inprogress_tasks.push(1) : ''
    end

    @total_templetes = []
    @course_creation_templetes.each do |course_creation_templete|
      if @empire_course.extra_s == course_creation_templete.extra_s
        @total_templetes.push(1)
      end
    end

  end

  # GET /empire_courses/new
  def new
    @empire_course = EmpireCourse.new
    form_collection
  end

  # GET /empire_courses/1/edit
  def edit
    form_collection
  end

  # POST /empire_courses
  # POST /empire_courses.json
  def create
    @empire_course = EmpireCourse.new(empire_course_params)

    respond_to do |format|
      if @empire_course.save
        format.html { redirect_to @empire_course, notice: 'Empire course was successfully created.' }
        format.json { render :show, status: :created, location: @empire_course }
      else
        format.html { render :new }
        format.json { render json: @empire_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_courses/1
  # PATCH/PUT /empire_courses/1.json
  def update
    respond_to do |format|
      if @empire_course.update(empire_course_params)
        format.html { redirect_to @empire_course, notice: 'Empire course was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_course }
      else
        format.html { render :edit }
        format.json { render json: @empire_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_courses/1
  # DELETE /empire_courses/1.json
  def destroy
    @empire_course.destroy
    respond_to do |format|
      format.html { redirect_to empire_courses_url, notice: 'Empire course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def form_collection
    @templete_type = ['ARELLO','California Course']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_course
      @empire_course = EmpireCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_course_params
      params.require(:empire_course).permit(:number, :version, :title, :category, :hours, :extra_i, :extra_d, :extra_b, :extra_s)
    end
end
