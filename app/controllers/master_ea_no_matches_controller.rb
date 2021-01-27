class MasterEaNoMatchesController < ApplicationController
  before_action :set_master_ea_no_match, only: [:show, :edit, :update, :destroy]

  # GET /master_ea_no_matches
  # GET /master_ea_no_matches.json
  def index
    @master_ea_no_matches = MasterEaNoMatch.all

    # Remove All
    if params['remove_all'] == 'yes' && params['confirm'] == 'yes'
      MasterEaNoMatch.delete_all
      redirect_to master_ea_no_matches_path(), note: 'Records Deleted'
    end

    respond_to do |format|
      format.html
      format.csv { send_data @master_ea_no_matches.to_csv, filename: "Sequoia-no-matched-customers-ea-#{Date.today}.csv" }
    end

    if params['no_match'] == 'yes'
      uid = params['uid'].to_i
      lname = SCustomer.where(uid: uid).pluck(:lname)
      list_1 = MasterEa.first(1)
      list = list_1.pluck(:list)
      new = MasterEaNoMatch.create(
      uid: uid,
      lname: lname[0],
      list: list[0],
      search_date: Date.today,
      )
      new.save
      redirect_to master_eas_path(), notice: "UID #{uid} was added to 'No Match' table"
    end

  end

  # GET /master_ea_no_matches/1
  # GET /master_ea_no_matches/1.json
  def show
  end

  # GET /master_ea_no_matches/new
  def new
    @master_ea_no_match = MasterEaNoMatch.new
  end

  # GET /master_ea_no_matches/1/edit
  def edit
  end

  # POST /master_ea_no_matches
  # POST /master_ea_no_matches.json
  def create
    @master_ea_no_match = MasterEaNoMatch.new(master_ea_no_match_params)

    respond_to do |format|
      if @master_ea_no_match.save
        format.html { redirect_to @master_ea_no_match, notice: 'Master ea no match was successfully created.' }
        format.json { render :show, status: :created, location: @master_ea_no_match }
      else
        format.html { render :new }
        format.json { render json: @master_ea_no_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_ea_no_matches/1
  # PATCH/PUT /master_ea_no_matches/1.json
  def update
    respond_to do |format|
      if @master_ea_no_match.update(master_ea_no_match_params)
        format.html { redirect_to @master_ea_no_match, notice: 'Master ea no match was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_ea_no_match }
      else
        format.html { render :edit }
        format.json { render json: @master_ea_no_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_ea_no_matches/1
  # DELETE /master_ea_no_matches/1.json
  def destroy
    @master_ea_no_match.destroy
    respond_to do |format|
      format.html { redirect_to master_ea_no_matches_url, notice: 'Master ea no match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    MasterEaNoMatch.my_import(params[:file])
    redirect_to master_ea_no_matches_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_ea_no_match
      @master_ea_no_match = MasterEaNoMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_ea_no_match_params
      params.require(:master_ea_no_match).permit(:uid, :lname, :list, :search_date)
    end
end
