class PostcardRecordsController < ApplicationController
  before_action :set_postcard_record, only: [:show, :edit, :update, :destroy]

  # GET /postcard_records
  # GET /postcard_records.json
  def index
    @postcard_records = PostcardRecord.all
  end

  # GET /postcard_records/1
  # GET /postcard_records/1.json
  def show
  end

  # GET /postcard_records/new
  def new
    @postcard_record = PostcardRecord.new
  end

  # GET /postcard_records/1/edit
  def edit
  end

  # POST /postcard_records
  # POST /postcard_records.json
  def create
    @postcard_record = PostcardRecord.new(postcard_record_params)

    respond_to do |format|
      if @postcard_record.save
        format.html { redirect_to @postcard_record, notice: 'Postcard record was successfully created.' }
        format.json { render :show, status: :created, location: @postcard_record }
      else
        format.html { render :new }
        format.json { render json: @postcard_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postcard_records/1
  # PATCH/PUT /postcard_records/1.json
  def update
    respond_to do |format|
      if @postcard_record.update(postcard_record_params)
        format.html { redirect_to @postcard_record, notice: 'Postcard record was successfully updated.' }
        format.json { render :show, status: :ok, location: @postcard_record }
      else
        format.html { render :edit }
        format.json { render json: @postcard_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postcard_records/1
  # DELETE /postcard_records/1.json
  def destroy
    @postcard_record.destroy
    respond_to do |format|
      format.html { redirect_to postcard_records_url, notice: 'Postcard record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postcard_record
      @postcard_record = PostcardRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postcard_record_params
      params.require(:postcard_record).permit(:company, :group, :mailing_id, :mail_date, :card, :sent)
    end
end
