class MasterCpaMatchesController < ApplicationController
  before_action :set_master_cpa_match, only: [:show, :edit, :update, :destroy]

  # GET /master_cpa_matches
  # GET /master_cpa_matches.json
  def index
    @master_cpa_matches = MasterCpaMatch.all

    respond_to do |format|
      format.html
      format.csv { send_data @master_cpa_matches.to_csv, filename: "Sequoia-matched-customers-cpa-#{Date.today}.csv" }
    end

  end

  # GET /master_cpa_matches/1
  # GET /master_cpa_matches/1.json
  def show
  end

  # GET /master_cpa_matches/new
  def new
    @master_cpa_match = MasterCpaMatch.new
  end

  # GET /master_cpa_matches/1/edit
  def edit
  end

  # POST /master_cpa_matches
  # POST /master_cpa_matches.json
  def create
    @master_cpa_match = MasterCpaMatch.new(master_cpa_match_params)

    respond_to do |format|
      if @master_cpa_match.save
        format.html { redirect_to @master_cpa_match, notice: 'Master cpa match was successfully created.' }
        format.json { render :show, status: :created, location: @master_cpa_match }
      else
        format.html { render :new }
        format.json { render json: @master_cpa_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_cpa_matches/1
  # PATCH/PUT /master_cpa_matches/1.json
  def update
    respond_to do |format|
      if @master_cpa_match.update(master_cpa_match_params)
        format.html { redirect_to @master_cpa_match, notice: 'Master cpa match was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_cpa_match }
      else
        format.html { render :edit }
        format.json { render json: @master_cpa_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_cpa_matches/1
  # DELETE /master_cpa_matches/1.json
  def destroy
    @master_cpa_match.destroy
    respond_to do |format|
      format.html { redirect_to master_cpa_matches_url, notice: 'Master cpa match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_cpa_match
      @master_cpa_match = MasterCpaMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_cpa_match_params
      params.require(:master_cpa_match).permit(:uid, :lname, :list, :search_date)
    end
end
