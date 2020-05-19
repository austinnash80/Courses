class EmpireRcStatesController < ApplicationController
  before_action :set_empire_rc_state, only: [:show, :edit, :update, :destroy]

  # GET /empire_rc_states
  # GET /empire_rc_states.json
  def index
    @empire_rc_states = EmpireRcState.order(state: :ASC).all


    # UPDATE & MATCH STATE - ONLY WHEN CLICKED
    if params['update_customers'].present?
      if params['update_customers'] == "MO_B" || params['update_customers'] == "MO_S"
        st = "MO"
      else
        st = params['update_customers']
      end
      rc_state = EmpireRcState.where(state: params['update_customers']).all
      master_list_name = rc_state.pluck(:master_list_name)

      ## FIND THE UNIQUE CUSTOMERS FROM THE GIVEN STATE. ADD TO ARRAY AND UPDATE THE RC STATE TABLE
        all_customers = []
        EmpireCustomer.where(lic_state: st).where.not(license_num: nil).all.each do |empire_customer|
          unless all_customers.include?(empire_customer.license_num)
            all_customers.push(empire_customer.license_num)
          end
        end
        rc_state.update_all customers: all_customers.count
      ## MATCH
        EmpireMasterList.where(source: st).where(license_number: all_customers).each do |master|
          EmpireCustomer.where(lic_state: st).where(license_num: master.license_number).update_all b_exp: master.exp_date, b_list: master.list, empire_master_list_id: master.id
        end
      ## UPDATE MATCHED CUSTOMERS IN RC STATE TABLE
        matched_customers = EmpireCustomer.where(b_list: master_list_name[0]).count
        rc_state.update_all matched_customers: matched_customers

      redirect_to empire_rc_states_path(st: params['update_customers']), notice: "#{st} customer update complete"
    end # END UPDATE & MATCH

  end

  def upload_list
    @count = EmpireMasterList.where(source: params['st']).count
    @name = EmpireMasterList.where(source: params['st']).first(1).pluck(:list)
    if params['delete_confirm'] == 'yes' && params['st'].present?
      EmpireMasterList.where(source: params['st']).delete_all
      EmpireRcState.where(state: params['st']).update_all master_list_name: '', master_list_quantity: 0
      redirect_to upload_list_empire_rc_states_path(st: params['st']), notice: "#{params['st']} master list was deleted"
    end
    if params['upload'] == 'complete'
      EmpireRcState.where(state: params['st']).update_all master_list_name: @name[0], master_list_quantity: @count
      redirect_to empire_rc_states_path(st: params['st']), notice: "#{params['st']} master list was uploaded"
    end
  end

  # GET /empire_rc_states/1
  # GET /empire_rc_states/1.json
  def show
  end

  # GET /empire_rc_states/new
  def new
    @empire_rc_state = EmpireRcState.new
  end

  # GET /empire_rc_states/1/edit
  def edit
  end

  # POST /empire_rc_states
  # POST /empire_rc_states.json
  def create
    @empire_rc_state = EmpireRcState.new(empire_rc_state_params)

    respond_to do |format|
      if @empire_rc_state.save
        format.html { redirect_to empire_rc_states_path, notice: 'Empire rc state was successfully created.' }
        format.json { render :show, status: :created, location: @empire_rc_state }
      else
        format.html { render :new }
        format.json { render json: @empire_rc_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_rc_states/1
  # PATCH/PUT /empire_rc_states/1.json
  def update
    respond_to do |format|
      if @empire_rc_state.update(empire_rc_state_params)
        format.html { redirect_to empire_rc_states_path, notice: 'Empire rc state was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_rc_state }
      else
        format.html { render :edit }
        format.json { render json: @empire_rc_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_rc_states/1
  # DELETE /empire_rc_states/1.json
  def destroy
    @empire_rc_state.destroy
    respond_to do |format|
      format.html { redirect_to empire_rc_states_url, notice: 'Empire rc state was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_rc_state
      @empire_rc_state = EmpireRcState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_rc_state_params
      params.require(:empire_rc_state).permit(:state, :exp_type, :master_list_name, :master_list_quantity, :master_list_update_date, :master_list_update_next, :list_notes, :customers, :matched_customers, :exp_date)
    end
end
