class SeqNoMailsController < ApplicationController
  before_action :set_seq_no_mail, only: [:show, :edit, :update, :destroy]

  # GET /seq_no_mails
  # GET /seq_no_mails.json
  def index
    @seq_no_mails = SeqNoMail.all

    respond_to do |format|
      format.html
      format.csv { send_data @seq_no_mails.to_csv, filename: "seq_no_mails-#{Date.today}.csv" }
      # format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  # GET /seq_no_mails/1
  # GET /seq_no_mails/1.json
  def show
  end

  # GET /seq_no_mails/new
  def new
    @seq_no_mail = SeqNoMail.new
  end

  # GET /seq_no_mails/1/edit
  def edit
  end

  # POST /seq_no_mails
  # POST /seq_no_mails.json
  def create
    @seq_no_mail = SeqNoMail.new(seq_no_mail_params)

    respond_to do |format|
      if @seq_no_mail.save
        format.html { redirect_to @seq_no_mail, notice: 'Seq no mail was successfully created.' }
        format.json { render :show, status: :created, location: @seq_no_mail }
      else
        format.html { render :new }
        format.json { render json: @seq_no_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seq_no_mails/1
  # PATCH/PUT /seq_no_mails/1.json
  def update
    respond_to do |format|
      if @seq_no_mail.update(seq_no_mail_params)
        format.html { redirect_to @seq_no_mail, notice: 'Seq no mail was successfully updated.' }
        format.json { render :show, status: :ok, location: @seq_no_mail }
      else
        format.html { render :edit }
        format.json { render json: @seq_no_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seq_no_mails/1
  # DELETE /seq_no_mails/1.json
  def destroy
    @seq_no_mail.destroy
    respond_to do |format|
      format.html { redirect_to seq_no_mails_url, notice: 'Seq no mail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    SeqNoMail.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to seq_no_mails_path
  end

  def import #Uploading CSV function
    SeqNoMail.import(params[:file])
    redirect_to seq_no_mails_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seq_no_mail
      @seq_no_mail = SeqNoMail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seq_no_mail_params
      params.require(:seq_no_mail).permit(:first_name, :mi, :last_name, :suf, :co, :address, :address_2, :city, :state, :zip, :date_added, :extra_i, :extra_b, :extra_s)
    end
end
