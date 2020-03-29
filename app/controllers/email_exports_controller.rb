class EmailExportsController < ApplicationController
  before_action :set_email_export, only: [:show, :edit, :update, :destroy]

  # GET /email_exports
  # GET /email_exports.json
  def index
    @email_exports = EmailExport.all
    @send_email = EmailExport.where(send_email: 'yes').all

    respond_to do |format|
      format.html
      format.csv { send_data @email_exports.to_csv, filename: "empire_weekly_rolling_state_email_#{Date.today}.csv" }
      # format.csv { send_data @email_exports.to_csv, filename: "empire_weekly_rolling_state_email_#{Date.today}.csv" }
    end

  end

  # GET /email_exports/1
  # GET /email_exports/1.json
  def show
  end

  # GET /email_exports/new
  def new
    @email_export = EmailExport.new
  end

  # GET /email_exports/1/edit
  def edit
  end

  # POST /email_exports
  # POST /email_exports.json
  def create
    @email_export = EmailExport.new(email_export_params)

    respond_to do |format|
      if @email_export.save
        format.html { redirect_to @email_export, notice: 'Email export was successfully created.' }
        format.json { render :show, status: :created, location: @email_export }
      else
        format.html { render :new }
        format.json { render json: @email_export.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_exports/1
  # PATCH/PUT /email_exports/1.json
  def update
    respond_to do |format|
      if @email_export.update(email_export_params)
        format.html { redirect_to @email_export, notice: 'Email export was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_export }
      else
        format.html { render :edit }
        format.json { render json: @email_export.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_exports/1
  # DELETE /email_exports/1.json
  def destroy
    @email_export.destroy
    respond_to do |format|
      format.html { redirect_to email_exports_url, notice: 'Email export was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_export
      @email_export = EmailExport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_export_params
      params.require(:email_export).permit(:empire_customer_id, :uid, :list, :license_number, :send_email, :company, :group, :send_date, :exp_b, :subject, :merge_1, :merge_2, :merge_3, :merge_4, :merge_5, :merge_6, :f_name, :l_name, :email)
    end
end
