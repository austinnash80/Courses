class MailingsController < ApplicationController
  before_action :set_mailing, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /mailings
  # GET /mailings.json
  def index
    @mailings = Mailing.order(sort_column + " " + sort_direction)
  end

  # GET /mailings/1
  # GET /mailings/1.json
  def show
  end

  # GET /mailings/new
  def new
    @mailing = Mailing.new
  end

  # GET /mailings/1/edit
  def edit
  end

  # POST /mailings
  # POST /mailings.json
  def create
    @mailing = Mailing.new(mailing_params)

    respond_to do |format|
      if @mailing.save
        format.html { redirect_to @mailing, notice: 'Mailing was successfully created.' }
        format.json { render :show, status: :created, location: @mailing }
      else
        format.html { render :new }
        format.json { render json: @mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mailings/1
  # PATCH/PUT /mailings/1.json
  def update
    respond_to do |format|
      if @mailing.update(mailing_params)
        format.html { redirect_to @mailing, notice: 'Mailing was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailing }
      else
        format.html { render :edit }
        format.json { render json: @mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailings/1
  # DELETE /mailings/1.json
  def destroy
    @mailing.destroy
    respond_to do |format|
      format.html { redirect_to mailings_url, notice: 'Mailing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    Mailing.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to mailings_path
  end

  def import
    Mailing.my_import(params[:file])
    redirect_to mailings_path, notice: "upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing
      @mailing = Mailing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_params
      params.require(:mailing).permit(:name, :drop, :date_extra, :who, :what, :quantity_sent, :group_1, :group_2, :group_3, :group_4, :group_5, :data_name, :art_name, :msi_note, :note_1, :note_2, :note_3, :complete, :boolean_1, :integer_1, :cost_service, :cost_print, :msi_art, :msi_data, :msi_invoice, :note_4)
    end

    def sort_column
      Mailing.column_names.include?(params[:sort]) ? params[:sort] : "drop"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
