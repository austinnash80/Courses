class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    form_collection
  end

  # GET /tasks/new
  def new
    @task = Task.new
    form_collection
  end

  # GET /tasks/1/edit
  def edit
    form_collection
  end

  # GET /tasks/1/edit
  def update_status
    form_collection
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    form_collection
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def form_collection
    @task_assign = ['Austin', 'Kyle', 'Michael', 'Ashley', 'Hamdo', 'John']
    @task_status = [['Current', 'Current'], ['Future', 'Future'],['Complete', 'Complete']]
    @due_date = [['Due Date', true], ['No Due Date', false]]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :note, :due, :due_date, :done, :important, :type_one, :type_two, :type_three, :extra_boolean, :extra_string, :extra_integer, :user_id, :update_note, :user_1, :user_2, :user_3, :user_4, :user_5, :user_6, :user_7, :additional_note_2, :additional_note_3, :no_due_date, :task_doc_1, :task_doc_2)
    end
end
