class SequoiaExamsController < ApplicationController
  before_action :set_sequoia_exam, only: [:show, :edit, :update, :destroy]

  # GET /sequoia_exams
  # GET /sequoia_exams.json
  def index
    @sequoia_exams = SequoiaExam.all
  end

  # GET /sequoia_exams/1
  # GET /sequoia_exams/1.json
  def show
  end

  # GET /sequoia_exams/new
  def new
    @sequoia_exam = SequoiaExam.new
  end

  # GET /sequoia_exams/1/edit
  def edit
  end

  # POST /sequoia_exams
  # POST /sequoia_exams.json
  def create
    @sequoia_exam = SequoiaExam.new(sequoia_exam_params)

    respond_to do |format|
      if @sequoia_exam.save
        format.html { redirect_to @sequoia_exam, notice: 'Sequoia exam was successfully created.' }
        format.json { render :show, status: :created, location: @sequoia_exam }
      else
        format.html { render :new }
        format.json { render json: @sequoia_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequoia_exams/1
  # PATCH/PUT /sequoia_exams/1.json
  def update
    respond_to do |format|
      if @sequoia_exam.update(sequoia_exam_params)
        format.html { redirect_to @sequoia_exam, notice: 'Sequoia exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @sequoia_exam }
      else
        format.html { render :edit }
        format.json { render json: @sequoia_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequoia_exams/1
  # DELETE /sequoia_exams/1.json
  def destroy
    @sequoia_exam.destroy
    respond_to do |format|
      format.html { redirect_to sequoia_exams_url, notice: 'Sequoia exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    SequoiaExam.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to sequoia_exams_path
  end

  def import
    SequoiaExam.my_import(params[:file])
    redirect_to sequoia_exams_path, notice: "upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequoia_exam
      @sequoia_exam = SequoiaExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequoia_exam_params
      params.require(:sequoia_exam).permit(:aid, :lid, :uid, :who, :date_s, :date_c, :course_number, :course_version, :course_title, :score, :rate, :extra_i, :extra_s, :extra_b)
    end
end
