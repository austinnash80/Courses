class EmpireMasterNoMatchesController < ApplicationController
  before_action :set_empire_master_no_match, only: [:show, :edit, :update, :destroy]

  # GET /empire_master_no_matches
  # GET /empire_master_no_matches.json
  def index
    @empire_master_no_matches = EmpireMasterNoMatch.all

    if params['path'] == 'ny_export_empire_master_no_matches'
      respond_to do |format|
        format.html
        format.csv { send_data @empire_master_no_matches.where(source: 'NY').where(double: false).to_csv, filename: "ny-empire-master-no-matches-#{Date.today}.csv" }
      end
    end
    if params['path'] == 'ny_export_empire_master_doubles'
      respond_to do |format|
        format.html
        format.csv { send_data @empire_master_no_matches.where(source: 'NY').where(double: true).to_csv, filename: "ny-empire-master-doubles-#{Date.today}.csv" }
      end
    end

    # Remove all records before new list import
    if params['remove_all'] == 'yes' && params['confirm'] == 'yes'
      EmpireMasterNoMatch.delete_all
      redirect_to empire_master_no_matches_path(), note: 'Records Deleted'
    end

  end

  # GET /empire_master_no_matches/1
  # GET /empire_master_no_matches/1.json
  def show
  end

  # GET /empire_master_no_matches/new
  def new
    @empire_master_no_match = EmpireMasterNoMatch.new
  end

  # GET /empire_master_no_matches/1/edit
  def edit
  end

  # POST /empire_master_no_matches
  # POST /empire_master_no_matches.json
  def create
    @empire_master_no_match = EmpireMasterNoMatch.new(empire_master_no_match_params)

    respond_to do |format|
      if @empire_master_no_match.save
        format.html { redirect_to @empire_master_no_match, notice: 'Empire master no match was successfully created.' }
        format.json { render :show, status: :created, location: @empire_master_no_match }
      else
        format.html { render :new }
        format.json { render json: @empire_master_no_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_master_no_matches/1
  # PATCH/PUT /empire_master_no_matches/1.json
  def update
    respond_to do |format|
      if @empire_master_no_match.update(empire_master_no_match_params)
        format.html { redirect_to @empire_master_no_match, notice: 'Empire master no match was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_master_no_match }
      else
        format.html { render :edit }
        format.json { render json: @empire_master_no_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_master_no_matches/1
  # DELETE /empire_master_no_matches/1.json
  def destroy
    @empire_master_no_match.destroy
    respond_to do |format|
      format.html { redirect_to empire_master_no_matches_url, notice: 'Empire master no match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    EmpireMasterNoMatch.my_import(params[:file])
    redirect_to empire_master_no_matches_path(), notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_master_no_match
      @empire_master_no_match = EmpireMasterNoMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_master_no_match_params
      params.require(:empire_master_no_match).permit(:uid, :last_name, :list, :search_date, :double, :source)
    end
end
