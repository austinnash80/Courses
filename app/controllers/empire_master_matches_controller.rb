class EmpireMasterMatchesController < ApplicationController
  before_action :set_empire_master_match, only: [:show, :edit, :update, :destroy]

  # GET /empire_master_matches
  # GET /empire_master_matches.json
  def index
    @empire_master_matches = EmpireMasterMatch.all

    respond_to do |format|
      format.html
      format.csv { send_data @empire_master_matches.where(source: 'NY').to_csv, filename: "ny-empire-master-matches-#{Date.today}.csv" }
    end

    # Remove all records before new list import
    if params['remove_all'] == 'yes' && params['confirm'] == 'yes'
      EmpireMasterMatch.delete_all
      redirect_to empire_master_matches_path(), note: 'Records Deleted'
    end
  end

  # GET /empire_master_matches/1
  # GET /empire_master_matches/1.json
  def show
  end

  # GET /empire_master_matches/new
  def new
    @empire_master_match = EmpireMasterMatch.new
  end

  # GET /empire_master_matches/1/edit
  def edit
  end

  # POST /empire_master_matches
  # POST /empire_master_matches.json
  def create
    @empire_master_match = EmpireMasterMatch.new(empire_master_match_params)

    respond_to do |format|
      if @empire_master_match.save
        format.html { redirect_to @empire_master_match, notice: 'Empire master match was successfully created.' }
        format.json { render :show, status: :created, location: @empire_master_match }
      else
        format.html { render :new }
        format.json { render json: @empire_master_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_master_matches/1
  # PATCH/PUT /empire_master_matches/1.json
  def update
    respond_to do |format|
      if @empire_master_match.update(empire_master_match_params)
        format.html { redirect_to @empire_master_match, notice: 'Empire master match was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_master_match }
      else
        format.html { render :edit }
        format.json { render json: @empire_master_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_master_matches/1
  # DELETE /empire_master_matches/1.json
  def destroy
    @empire_master_match.destroy
    respond_to do |format|
      format.html { redirect_to empire_master_matches_url, notice: 'Empire master match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    EmpireMasterMatch.my_import(params[:file])
    redirect_to empire_master_matches_path(), notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_master_match
      @empire_master_match = EmpireMasterMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_master_match_params
      params.require(:empire_master_match).permit(:uid, :last_name, :list, :lid, :search_date, :source)
    end
end
