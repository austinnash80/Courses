class TxRoyaltiesController < ApplicationController
  before_action :set_tx_royalty, only: [:show, :edit, :update, :destroy]

  # GET /tx_royalties
  # GET /tx_royalties.json
  def index
    @tx_royalties = TxRoyalty.all
  end

  # GET /tx_royalties/1
  # GET /tx_royalties/1.json
  def show
  end

  # GET /tx_royalties/new
  def new
    @tx_royalty = TxRoyalty.new
  end

  # GET /tx_royalties/1/edit
  def edit
  end

  # POST /tx_royalties
  # POST /tx_royalties.json
  def create
    @tx_royalty = TxRoyalty.new(tx_royalty_params)

    respond_to do |format|
      if @tx_royalty.save
        format.html { redirect_to @tx_royalty, notice: 'Tx royalty was successfully created.' }
        format.json { render :show, status: :created, location: @tx_royalty }
      else
        format.html { render :new }
        format.json { render json: @tx_royalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tx_royalties/1
  # PATCH/PUT /tx_royalties/1.json
  def update
    respond_to do |format|
      if @tx_royalty.update(tx_royalty_params)
        format.html { redirect_to @tx_royalty, notice: 'Tx royalty was successfully updated.' }
        format.json { render :show, status: :ok, location: @tx_royalty }
      else
        format.html { render :edit }
        format.json { render json: @tx_royalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tx_royalties/1
  # DELETE /tx_royalties/1.json
  def destroy
    @tx_royalty.destroy
    respond_to do |format|
      format.html { redirect_to tx_royalties_url, notice: 'Tx royalty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tx_royalty
      @tx_royalty = TxRoyalty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tx_royalty_params
      params.require(:tx_royalty).permit(:quarter, :start_date, :end_date, :sent_date, :sold, :cost, :percentage, :sent, :extra_i, :extra_b, :extra_s)
    end
end
