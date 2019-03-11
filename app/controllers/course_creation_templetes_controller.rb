class CourseCreationTempletesController < ApplicationController
  before_action :set_course_creation_templete, only: [:show, :edit, :update, :destroy]

  # GET /course_creation_templetes
  # GET /course_creation_templetes.json
  def index
    @course_creation_templetes = CourseCreationTemplete.order(:id).all
  end

  # GET /course_creation_templetes/1
  # GET /course_creation_templetes/1.json
  def show
  end

  # GET /course_creation_templetes/new
  def new
    @course_creation_templete = CourseCreationTemplete.new
  end

  # GET /course_creation_templetes/1/edit
  def edit
  end

  # POST /course_creation_templetes
  # POST /course_creation_templetes.json
  def create
    @course_creation_templete = CourseCreationTemplete.new(course_creation_templete_params)

    respond_to do |format|
      if @course_creation_templete.save
        format.html { redirect_to @course_creation_templete, notice: 'Course creation template was successfully created.' }
        format.json { render :show, status: :created, location: @course_creation_templete }
      else
        format.html { render :new }
        format.json { render json: @course_creation_templete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_creation_templetes/1
  # PATCH/PUT /course_creation_templetes/1.json
  def update
    respond_to do |format|
      if @course_creation_templete.update(course_creation_templete_params)
        format.html { redirect_to @course_creation_templete, notice: 'Course creation templete was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_creation_templete }
      else
        format.html { render :edit }
        format.json { render json: @course_creation_templete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_creation_templetes/1
  # DELETE /course_creation_templetes/1.json
  def destroy
    @course_creation_templete.destroy
    respond_to do |format|
      format.html { redirect_to course_creation_templetes_url, notice: 'Course creation templete was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_creation_templete
      @course_creation_templete = CourseCreationTemplete.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_creation_templete_params
      params.require(:course_creation_templete).permit(:templete_type, :instruction_1, :instruction_2, :extra_s, :extra_t, :extra_i, :extra_d, :extra_b)
    end
end
