class MasterCpaDoubleAccountsController < ApplicationController
  before_action :set_master_cpa_double_account, only: [:show, :edit, :update, :destroy]

  # GET /master_cpa_double_accounts
  # GET /master_cpa_double_accounts.json
  def index
    @master_cpa_double_accounts = MasterCpaDoubleAccount.all

  end

  # GET /master_cpa_double_accounts/1
  # GET /master_cpa_double_accounts/1.json
  def show
  end

  # GET /master_cpa_double_accounts/new
  def new
    @master_cpa_double_account = MasterCpaDoubleAccount.new
  end

  # GET /master_cpa_double_accounts/1/edit
  def edit
  end

  # POST /master_cpa_double_accounts
  # POST /master_cpa_double_accounts.json
  def create
    @master_cpa_double_account = MasterCpaDoubleAccount.new(master_cpa_double_account_params)

    respond_to do |format|
      if @master_cpa_double_account.save
        format.html { redirect_to @master_cpa_double_account, notice: 'Master cpa double account was successfully created.' }
        format.json { render :show, status: :created, location: @master_cpa_double_account }
      else
        format.html { render :new }
        format.json { render json: @master_cpa_double_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_cpa_double_accounts/1
  # PATCH/PUT /master_cpa_double_accounts/1.json
  def update
    respond_to do |format|
      if @master_cpa_double_account.update(master_cpa_double_account_params)
        format.html { redirect_to @master_cpa_double_account, notice: 'Master cpa double account was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_cpa_double_account }
      else
        format.html { render :edit }
        format.json { render json: @master_cpa_double_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_cpa_double_accounts/1
  # DELETE /master_cpa_double_accounts/1.json
  def destroy
    @master_cpa_double_account.destroy
    respond_to do |format|
      format.html { redirect_to master_cpa_double_accounts_url, notice: 'Master cpa double account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_cpa_double_account
      @master_cpa_double_account = MasterCpaDoubleAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_cpa_double_account_params
      params.require(:master_cpa_double_account).permit(:uid, :lname, :string, :uid, :search_date, :lid, :list)
    end
end
