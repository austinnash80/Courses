class PostcardMailingsController < ApplicationController
  before_action :set_postcard_mailing, only: [:show, :edit, :update, :destroy]

  # GET /postcard_mailings
  # GET /postcard_mailings.json
  def index
    @postcard_mailings = PostcardMailing.all
  end

  # GET /postcard_mailings/1
  # GET /postcard_mailings/1.json
  def show
  end

  # GET /postcard_mailings/new
  def new
    @postcard_mailing = PostcardMailing.new
  end

  # GET /postcard_mailings/1/edit
  def edit
  end

  # POST /postcard_mailings
  # POST /postcard_mailings.json
  def create
    @postcard_mailing = PostcardMailing.new(postcard_mailing_params)

    respond_to do |format|
      if @postcard_mailing.save
        format.html { redirect_to @postcard_mailing, notice: 'Postcard mailing was successfully created.' }
        format.json { render :show, status: :created, location: @postcard_mailing }
      else
        format.html { render :new }
        format.json { render json: @postcard_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postcard_mailings/1
  # PATCH/PUT /postcard_mailings/1.json
  def update
    respond_to do |format|
      if @postcard_mailing.update(postcard_mailing_params)
        format.html { redirect_to @postcard_mailing, notice: 'Postcard mailing was successfully updated.' }
        format.json { render :show, status: :ok, location: @postcard_mailing }
      else
        format.html { render :edit }
        format.json { render json: @postcard_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postcard_mailings/1
  # DELETE /postcard_mailings/1.json
  def destroy
    @postcard_mailing.destroy
    respond_to do |format|
      format.html { redirect_to postcard_mailings_url, notice: 'Postcard mailing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postcard_mailing
      @postcard_mailing = PostcardMailing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postcard_mailing_params
      params.require(:postcard_mailing).permit(:company, :version, :sent, :date_sent, :number_sent, :note, :extra_i, :extra_b, :extra_s)
    end
end
