class EmailCampaignsController < ApplicationController
  before_action :set_email_campaign, only: [:show, :edit, :update, :destroy]

  # GET /email_campaigns
  # GET /email_campaigns.json
  def index
    @email_campaigns = EmailCampaign.all
  end

  # GET /email_campaigns/1
  # GET /email_campaigns/1.json
  def show
  end

  # GET /email_campaigns/new
  def new
    @email_campaign = EmailCampaign.new
  end

  # GET /email_campaigns/1/edit
  def edit
  end

  # POST /email_campaigns
  # POST /email_campaigns.json
  def create
    @email_campaign = EmailCampaign.new(email_campaign_params)

    respond_to do |format|
      if @email_campaign.save
        format.html { redirect_to @email_campaign, notice: 'Email campaign was successfully created.' }
        format.json { render :show, status: :created, location: @email_campaign }
      else
        format.html { render :new }
        format.json { render json: @email_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_campaigns/1
  # PATCH/PUT /email_campaigns/1.json
  def update
    respond_to do |format|
      if @email_campaign.update(email_campaign_params)
        format.html { redirect_to @email_campaign, notice: 'Email campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_campaign }
      else
        format.html { render :edit }
        format.json { render json: @email_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_campaigns/1
  # DELETE /email_campaigns/1.json
  def destroy
    @email_campaign.destroy
    respond_to do |format|
      format.html { redirect_to email_campaigns_url, notice: 'Email campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_campaign
      @email_campaign = EmailCampaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_campaign_params
      params.require(:email_campaign).permit(:company, :campaign_name, :delivery_service, :list_name, :segment, :segment_range, :segment_note, :start_date, :end_date, :active, :inactive, :tagline, :emails_sent, :delivered, :opened, :clicked, :blocked, :bounce, :spam, :extra_s, :extra_b, :extra_i, :update_stats)
    end
end
