class CourseCreationTasksController < ApplicationController
  before_action :set_course_creation_task, only: [:show, :edit, :update, :destroy]

  # GET /course_creation_tasks
  # GET /course_creation_tasks.json
  def index
    @course_creation_tasks = CourseCreationTask.order(:id).order(:course_creation_templete_id).all
  end

  # GET /course_creation_tasks/1
  # GET /course_creation_tasks/1.json
  def show
    form_collection
  end

  # GET /course_creation_tasks/new
  def new
    @course_creation_task = CourseCreationTask.new
    form_collection
  end

  # GET /course_creation_tasks/1/edit
  def edit
    form_collection
  end

  # POST /course_creation_tasks
  # POST /course_creation_tasks.json
  def create
    @course_creation_task = CourseCreationTask.new(course_creation_task_params)

    respond_to do |format|
      if @course_creation_task.save
        format.html { redirect_to empire_courses_path, notice: 'Course creation task was successfully created.' }
        format.json { render :show, status: :created, location: @course_creation_task }
      else
        format.html { render :new }
        format.json { render json: @course_creation_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_creation_tasks/1
  # PATCH/PUT /course_creation_tasks/1.json
  def update
    respond_to do |format|
      if @course_creation_task.update(course_creation_task_params)
        format.html { redirect_to empire_courses_path, notice: 'Course creation task was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_creation_task }
      else
        format.html { render :edit }
        format.json { render json: @course_creation_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_creation_tasks/1
  # DELETE /course_creation_tasks/1.json
  def destroy
    @course_creation_task.destroy
    respond_to do |format|
      format.html { redirect_to course_creation_tasks_url, notice: 'Course creation task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def form_collection
    @templete = [[5,'Acquire source material'],[6,'Decide on course topic and length'],[7,'Add course content to InDesign'],[8,'Select Key Points'],[9,'Write questions'],[10,'Review and edit questions'],[11,'Divide questions'],
                [12,'Create exams'],[13,'Add exams to platform'],[14,'Write review question remediations'],[15,'Add review questions and explanations to InDesign'],[16,'Edit text'],[17,'Create table of contents'],[18,'Create PDF of course'],[19,'Create course listing on platform'],[20,'Upload course to AWS'],[21,'Apply course to DRE']]
    # @task = ['ARELLO','California Course']
    @assign = ['John', 'Michael', 'Ashley', 'Hamdo']
    @status = ['Complete']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_creation_task
      @course_creation_task = CourseCreationTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_creation_task_params
      params.require(:course_creation_task).permit(:empire_course_id, :course_creation_templete_id, :task, :task_note_1, :task_note_2, :task_note_3, :assign_1, :assign_2, :assign_3, :extra_s, :extra_t, :extra_i, :extra_d, :extra_b)
    end
end
