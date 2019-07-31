class TaskDeadlinesController < ApplicationController
  before_action :set_task_deadline, only: [:show, :edit, :update, :destroy]

  # GET /task_deadlines
  # GET /task_deadlines.json
  def index
    @task_deadlines = TaskDeadline.order(:date_s).all
  end

  # GET /task_deadlines/1
  # GET /task_deadlines/1.json
  def show
  end

  # GET /task_deadlines/new
  def new
    @task_deadline = TaskDeadline.new
  end

  # GET /task_deadlines/1/edit
  def edit
  end

  # POST /task_deadlines
  # POST /task_deadlines.json
  def create
    @task_deadline = TaskDeadline.new(task_deadline_params)

    respond_to do |format|
      if @task_deadline.save
        format.html { redirect_to task_deadlines_path, notice: 'Task deadline was successfully created.' }
        # format.html { redirect_to @task_deadline, notice: 'Task deadline was successfully created.' }
        format.json { render :show, status: :created, location: @task_deadline }
      else
        format.html { render :new }
        format.json { render json: @task_deadline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_deadlines/1
  # PATCH/PUT /task_deadlines/1.json
  def update
    respond_to do |format|
      if @task_deadline.update(task_deadline_params)
        format.html { redirect_to @task_deadline, notice: 'Task deadline was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_deadline }
      else
        format.html { render :edit }
        format.json { render json: @task_deadline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_deadlines/1
  # DELETE /task_deadlines/1.json
  def destroy
    @task_deadline.destroy
    respond_to do |format|
      format.html { redirect_to task_deadlines_url, notice: 'Task deadline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_deadline
      @task_deadline = TaskDeadline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_deadline_params
      params.require(:task_deadline).permit(:title, :state, :note, :status, :date_s, :date_f, :extra_s, :extra_i, :extra_b, :extra_d, :cost, :time)
    end
end
