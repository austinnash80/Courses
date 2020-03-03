class PostcardExportsController < ApplicationController
  before_action :set_postcard_export, only: [:show, :edit, :update, :destroy]

  # GET /postcard_exports
  # GET /postcard_exports.json
  def index
    # @postcard_exports = PostcardExport.all
    @mail_id = params['mail_id']

    @postcard_exports = PostcardExport.where(mail_id: @mail_id).all

    respond_to do |format|
      format.html
      format.csv { send_data @postcard_exports.to_csv, filename: "#{@mail_id}.csv" }
    end

    if params['record'] == 'yes'
      new = PostcardRecord.create(
        company: params['co'],
        group: params['group'],
        mailing_id: params['mail_id'],
        mail_date: params['day'],
        card: params['card'],
        sent: params['sent']
      )
      new.save
    end
  end

  # GET /postcard_exports/1
  # GET /postcard_exports/1.json
  def show
  end

  # GET /postcard_exports/new
  def new
    @postcard_export = PostcardExport.new
  end

  # GET /postcard_exports/1/edit
  def edit
  end

  # POST /postcard_exports
  # POST /postcard_exports.json
  def create
    @postcard_export = PostcardExport.new(postcard_export_params)

    respond_to do |format|
      if @postcard_export.save
        format.html { redirect_to @postcard_export, notice: 'Postcard export was successfully created.' }
        format.json { render :show, status: :created, location: @postcard_export }
      else
        format.html { render :new }
        format.json { render json: @postcard_export.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postcard_exports/1
  # PATCH/PUT /postcard_exports/1.json
  def update
    respond_to do |format|
      if @postcard_export.update(postcard_export_params)
        format.html { redirect_to @postcard_export, notice: 'Postcard export was successfully updated.' }
        format.json { render :show, status: :ok, location: @postcard_export }
      else
        format.html { render :edit }
        format.json { render json: @postcard_export.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postcard_exports/1
  # DELETE /postcard_exports/1.json
  def destroy
    @postcard_export.destroy
    respond_to do |format|
      format.html { redirect_to postcard_exports_url, notice: 'Postcard export was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postcard_export
      @postcard_export = PostcardExport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postcard_export_params
      params.require(:postcard_export).permit(:company, :group, :mail_id, :mail_date, :state, :list, :license_number, :uid, :merge_1, :merge_2, :merge_3, :f_name, :l_name, :add_1, :add_2, :city, :st, :zip, :email, :subject, :exp, :merge_4, :merge_5, :g_id, :extra_b, :extra_s, :extra_i)
    end
end
