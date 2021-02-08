class MasterEaDoubleAccountsController < ApplicationController
  before_action :set_master_ea_double_account, only: [:show, :edit, :update, :destroy]

  # GET /master_ea_double_accounts
  # GET /master_ea_double_accounts.json
  def index
    @master_ea_double_accounts = MasterEaDoubleAccount.all
    respond_to do |format|
      format.html
      format.csv { send_data @master_ea_double_accounts.to_csv, filename: "Sequoia-double-accounts-ea-#{Date.today}.csv" }
    end

    if params['path'] == 'uid_update'
       MasterEaDoubleAccount.all.each do |i|
         uid = MasterEaMatch.where(lid: i.lid).pluck(:uid)
         MasterEaDoubleAccount.where(id: i.id).update_all uid2: uid[0]
       end
       redirect_to master_ea_double_accounts_path(), notice: 'Update done'
    end

  end

  # GET /master_ea_double_accounts/1
  # GET /master_ea_double_accounts/1.json
  def show
  end

  # GET /master_ea_double_accounts/new
  def new
    @master_ea_double_account = MasterEaDoubleAccount.new
  end

  # GET /master_ea_double_accounts/1/edit
  def edit
  end

  # POST /master_ea_double_accounts
  # POST /master_ea_double_accounts.json
  def create
    @master_ea_double_account = MasterEaDoubleAccount.new(master_ea_double_account_params)

    respond_to do |format|
      if @master_ea_double_account.save
        format.html { redirect_to @master_ea_double_account, notice: 'Master ea double account was successfully created.' }
        format.json { render :show, status: :created, location: @master_ea_double_account }
      else
        format.html { render :new }
        format.json { render json: @master_ea_double_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_ea_double_accounts/1
  # PATCH/PUT /master_ea_double_accounts/1.json
  def update
    respond_to do |format|
      if @master_ea_double_account.update(master_ea_double_account_params)
        format.html { redirect_to @master_ea_double_account, notice: 'Master ea double account was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_ea_double_account }
      else
        format.html { render :edit }
        format.json { render json: @master_ea_double_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_ea_double_accounts/1
  # DELETE /master_ea_double_accounts/1.json
  def destroy
    @master_ea_double_account.destroy
    respond_to do |format|
      format.html { redirect_to master_ea_double_accounts_url, notice: 'Master ea double account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_ea_double_account
      @master_ea_double_account = MasterEaDoubleAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_ea_double_account_params
      params.require(:master_ea_double_account).permit(:uid, :lname, :lid, :list, :search_date, :uid2)
    end
end
