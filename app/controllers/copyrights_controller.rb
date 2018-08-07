class CopyrightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_copyright, only: [:show, :edit, :update, :destroy]

  # GET /copyrights
  # GET /copyrights.json
  def index
    @copyrights = Copyright.all
  end

  # GET /copyrights/1
  # GET /copyrights/1.json
  def show
  end

  # GET /copyrights/new
  def new
    @copyright = Copyright.new
  end

  # GET /copyrights/1/edit
  def edit
  end

  # POST /copyrights
  # POST /copyrights.json
  def create
    @copyright = Copyright.new(copyright_params)

    respond_to do |format|
      if @copyright.save
        format.html { redirect_to @copyright, notice: 'Copyright was successfully created.' }
        format.json { render :show, status: :created, location: @copyright }
      else
        format.html { render :new }
        format.json { render json: @copyright.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /copyrights/1
  # PATCH/PUT /copyrights/1.json
  def update
    respond_to do |format|
      if @copyright.update(copyright_params)
        format.html { redirect_to @copyright, notice: 'Copyright was successfully updated.' }
        format.json { render :show, status: :ok, location: @copyright }
      else
        format.html { render :edit }
        format.json { render json: @copyright.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /copyrights/1
  # DELETE /copyrights/1.json
  def destroy
    @copyright.destroy
    respond_to do |format|
      format.html { redirect_to copyrights_url, notice: 'Copyright was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_copyright
      @copyright = Copyright.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def copyright_params
      params.require(:copyright).permit(:seq_number, :publisher, :author, :book, :cpdate)
    end
end
