class LiveChatAnswersController < ApplicationController
  before_action :set_live_chat_answer, only: [:show, :edit, :update, :destroy]

  # GET /live_chat_answers
  # GET /live_chat_answers.json
  def index
    @live_chat_answers = LiveChatAnswer.all
  end

  # GET /live_chat_answers/1
  # GET /live_chat_answers/1.json
  def show
  end

  # GET /live_chat_answers/new
  def new
    @live_chat_answer = LiveChatAnswer.new
    form_collections
  end

  # GET /live_chat_answers/1/edit
  def edit
    form_collections
  end

  # POST /live_chat_answers
  # POST /live_chat_answers.json
  def create
    @live_chat_answer = LiveChatAnswer.new(live_chat_answer_params)

    respond_to do |format|
      if @live_chat_answer.save
        format.html { redirect_to @live_chat_answer, notice: 'Live chat answer was successfully created.' }
        format.json { render :show, status: :created, location: @live_chat_answer }
      else
        format.html { render :new }
        format.json { render json: @live_chat_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /live_chat_answers/1
  # PATCH/PUT /live_chat_answers/1.json
  def update
    respond_to do |format|
      if @live_chat_answer.update(live_chat_answer_params)
        format.html { redirect_to @live_chat_answer, notice: 'Live chat answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @live_chat_answer }
      else
        format.html { render :edit }
        format.json { render json: @live_chat_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /live_chat_answers/1
  # DELETE /live_chat_answers/1.json
  def destroy
    @live_chat_answer.destroy
    respond_to do |format|
      format.html { redirect_to live_chat_answers_url, notice: 'Live chat answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def form_collections
    @companies = ['Sequoia', 'Empire', 'Tax Preparers']
    @states = ['CA', 'TX', 'NY']
    @des = ['CPA', 'EA', 'Tax Preparer']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_live_chat_answer
      @live_chat_answer = LiveChatAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def live_chat_answer_params
      params.require(:live_chat_answer).permit(:company, :state, :des, :question, :topic, :answer, :notes, :date_org, :extra_i, :extra_s, :extra_d)
    end
end
