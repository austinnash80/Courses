class EmpireMailingsController < ApplicationController
  before_action :set_empire_mailing, only: [:show, :edit, :update, :destroy]

  # GET /empire_mailings
  # GET /empire_mailings.json
  def index
    @empire_mailings = EmpireMailing.all
  end

  # GET /empire_mailings/1
  # GET /empire_mailings/1.json
  def show
  end

  # GET /empire_mailings/new
  def new
    @empire_mailing = EmpireMailing.new
  end

  # GET /empire_mailings/1/edit
  def edit
  end

  # POST /empire_mailings
  # POST /empire_mailings.json
  def create
    @empire_mailing = EmpireMailing.new(empire_mailing_params)

    respond_to do |format|
      if @empire_mailing.save
        format.html { redirect_to @empire_mailing, notice: 'Empire mailing was successfully created.' }
        format.json { render :show, status: :created, location: @empire_mailing }
      else
        format.html { render :new }
        format.json { render json: @empire_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_mailings/1
  # PATCH/PUT /empire_mailings/1.json
  def update
    respond_to do |format|
      if @empire_mailing.update(empire_mailing_params)
        format.html { redirect_to @empire_mailing, notice: 'Empire mailing was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_mailing }
      else
        format.html { render :edit }
        format.json { render json: @empire_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_mailings/1
  # DELETE /empire_mailings/1.json
  def destroy
    @empire_mailing.destroy
    respond_to do |format|
      format.html { redirect_to empire_mailings_url, notice: 'Empire mailing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_mailing
      @empire_mailing = EmpireMailing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_mailing_params
      params.require(:empire_mailing).permit(:name, :drop, :date_extra, :state, :what, :quanity_est, :quanity_sent, :group_1, :group_2, :group_3, :data_name, :art_name, :msi_note, :note_1, :note_2, :complete, :boolean_1, :integer_extra, :cost_service, :cost_print, :cost_postage)
    end
end
