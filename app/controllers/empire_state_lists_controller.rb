class EmpireStateListsController < ApplicationController
  before_action :set_empire_state_list, only: [:show, :edit, :update, :destroy]

  # GET /empire_state_lists
  # GET /empire_state_lists.json
  def index
    @empire_state_lists = EmpireStateList.all
  end

  # GET /empire_state_lists/1
  # GET /empire_state_lists/1.json
  def show
  end

  # GET /empire_state_lists/new
  def new
    @empire_state_list = EmpireStateList.new
    collections
  end

  # GET /empire_state_lists/1/edit
  def edit
    collections
  end

  # POST /empire_state_lists
  # POST /empire_state_lists.json
  def create
    @empire_state_list = EmpireStateList.new(empire_state_list_params)

    respond_to do |format|
      if @empire_state_list.save
        format.html { redirect_to empire_state_lists_path, notice: 'Empire state list was successfully created.' }
        format.json { render :show, status: :created, location: @empire_state_list }
      else
        format.html { render :new }
        format.json { render json: @empire_state_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_state_lists/1
  # PATCH/PUT /empire_state_lists/1.json
  def update
    respond_to do |format|
      if @empire_state_list.update(empire_state_list_params)
        format.html { redirect_to @empire_state_list, notice: 'Empire state list was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_state_list }
      else
        format.html { render :edit }
        format.json { render json: @empire_state_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_state_lists/1
  # DELETE /empire_state_lists/1.json
  def destroy
    @empire_state_list.destroy
    respond_to do |format|
      format.html { redirect_to empire_state_lists_url, notice: 'Empire state list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def collections
    @states = [ "AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_state_list
      @empire_state_list = EmpireStateList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_state_list_params
      params.require(:empire_state_list).permit(:st, :tilte, :cost, :notes, :extra_s, :list_file_name, :list_content_type, :list_file_size, :list_updated_at, :list_upload, :receipt_upload, :receipt)
    end
end
