class CallLogsController < ApplicationController
  before_action :set_call_log, only: [:show, :edit, :update, :destroy]

  # GET /call_logs
  # GET /call_logs.json
  def index
    @call_logs = CallLog.order(:call_date => 'desc').all
  end

  # GET /call_logs/1
  # GET /call_logs/1.json
  def show
  end

  # GET /call_logs/new
  def new
    @call_log = CallLog.new
    name
    form_collections
  end

  # GET /call_logs/1/edit
  def edit
    form_collections
  end

  # POST /call_logs
  # POST /call_logs.json
  def create
    @call_log = CallLog.new(call_log_params)

    respond_to do |format|
      if @call_log.save
        format.html { redirect_to @call_log, notice: 'Call log was successfully created.' }
        format.json { render :show, status: :created, location: @call_log }
      else
        format.html { render :new }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /call_logs/1
  # PATCH/PUT /call_logs/1.json
  def update
    respond_to do |format|
      if @call_log.update(call_log_params)
        format.html { redirect_to @call_log, notice: 'Call log was successfully updated.' }
        format.json { render :show, status: :ok, location: @call_log }
      else
        format.html { render :edit }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_logs/1
  # DELETE /call_logs/1.json
  def destroy
    @call_log.destroy
    respond_to do |format|
      format.html { redirect_to call_logs_url, notice: 'Call log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def name
    user_signed_in? && current_user.email == 'austin@sequoiacpe.com' ? @name = 'Austin' : ''
    user_signed_in? && current_user.email == 'michael@sequoiacpe.com' ? @name = 'Michael' : ''
    user_signed_in? && current_user.email == 'kyle@sequoiacpe.com' ? @name = 'Kyle' : ''
    user_signed_in? && current_user.email == 'ashley@sequoiacpe.com' ? @name = 'Ashley' : ''
    user_signed_in? && current_user.email == 'sabrina@sequoiacpe.com' ? @name = 'Sabrina' : ''
  end

  def form_collections
    @companies = ['Sequoia', 'Empire', 'Pacific', 'Tax Preparers']
    @rating = 1..3
    @q_topic = ['1','2','3','other']
    @des = ['CPA','EA', 'Tax Preparer', 'Empire', 'Unknown']
    @questions = ['Q1', 'Q2', 'Q3', 'Other']
    @answered = ['Answered', 'Not Answered']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call_log
      @call_log = CallLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_log_params
      params.require(:call_log).permit(:company, :caller_des, :caller_state, :customer, :caller_fname, :caller_lname, :UID, :call_length, :question_topic, :question_1, :question_2, :answered, :question_answer, :question_difficulty, :caller_satisfaction, :extra_b, :extra_i, :extra_s, :taken, :call_date, :note, :question_1_topic_other, :question_2_topic, :question_2_topic_other, :question_1_other, :question_2_other, :question_2_answered, :question_2_answer, :question_additional, :question_additional_answer, :question_satisfaction, :call_difficulty, :call_time)
    end
end
