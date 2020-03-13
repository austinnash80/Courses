class EmailRecordsController < ApplicationController
  before_action :set_email_record, only: [:show, :edit, :update, :destroy]

  # GET /email_records
  # GET /email_records.json
  def index
    @email_records = EmailRecord.all
  end

  # GET /email_records/1
  # GET /email_records/1.json
  def show
  end

  # GET /email_records/new
  def new
    @email_record = EmailRecord.new
  end

  # GET /email_records/1/edit
  def edit
  end

  # POST /email_records
  # POST /email_records.json
  def create
    @email_record = EmailRecord.new(email_record_params)

    respond_to do |format|
      if @email_record.save
        format.html { redirect_to @email_record, notice: 'Email record was successfully created.' }
        format.json { render :show, status: :created, location: @email_record }
      else
        format.html { render :new }
        format.json { render json: @email_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_records/1
  # PATCH/PUT /email_records/1.json
  def update
    respond_to do |format|
      if @email_record.update(email_record_params)
        format.html { redirect_to @email_record, notice: 'Email record was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_record }
      else
        format.html { render :edit }
        format.json { render json: @email_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_records/1
  # DELETE /email_records/1.json
  def destroy
    @email_record.destroy
    respond_to do |format|
      format.html { redirect_to email_records_url, notice: 'Email record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_record
      @email_record = EmailRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_record_params
      params.require(:email_record).permit(:company, :group, :mailing_id, :mail_date, :sent)
    end
end
