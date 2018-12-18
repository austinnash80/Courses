class CourseCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_comment, only: [:show, :edit, :update, :destroy]

  # GET /course_comments
  # GET /course_comments.json
  def index
    @course_comments = CourseComment.all
  end

  # GET /course_comments/1
  # GET /course_comments/1.json
  def show
  end

  # GET /course_comments/new
  def new
    @course_comment = CourseComment.new
    form_collections
    name
  end

  # GET /course_comments/1/edit
  def edit
    form_collections
  end

  # POST /course_comments
  # POST /course_comments.json
  def create
    @course_comment = CourseComment.new(course_comment_params)
    form_collections

    respond_to do |format|
      if @course_comment.save
        format.html { redirect_to @course_comment, notice: 'Course comment was successfully created.' }
        format.json { render :show, status: :created, location: @course_comment }
      else
        format.html { render :new }
        format.json { render json: @course_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_comments/1
  # PATCH/PUT /course_comments/1.json
  def update
    respond_to do |format|
      if @course_comment.update(course_comment_params)
        format.html { redirect_to @course_comment, notice: 'Course comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_comment }
      else
        format.html { render :edit }
        format.json { render json: @course_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_comments/1
  # DELETE /course_comments/1.json
  def destroy
    @course_comment.destroy
    respond_to do |format|
      format.html { redirect_to course_comments_url, notice: 'Course comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def name
    user_signed_in? && current_user.email == 'austin@sequoiacpe.com' ? @name = 'Austin' : ''
    user_signed_in? && current_user.email == 'michael@sequoiacpe.com' ? @name = 'Michael' : ''
    user_signed_in? && current_user.email == 'kyle@sequoiacpe.com' ? @name = 'Kyle' : ''
    user_signed_in? && current_user.email == 'ashley@sequoiacpe.com' ? @name = 'Ashley' : ''
    user_signed_in? && current_user.email == 'hamdo@sequoiacpe.com' ? @name = 'Hamdo' : ''
  end

  def form_collections
    @comment_types = ['Out of Date','General Quality','Confusing Question','Grammer Error','Content Error','Other']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_comment
      @course_comment = CourseComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_comment_params
      params.require(:course_comment).permit(:taken, :course_number, :course_version, :comment_type, :comment_type_other, :comment_details, :comment_date, :extra_s, :extra_i, :extra_b, :extra_d)
    end
end
