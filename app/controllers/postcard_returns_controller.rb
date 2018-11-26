class PostcardReturnsController < ApplicationController
  before_action :set_postcard_return, only: [:show, :edit, :update, :destroy]

  # GET /postcard_returns
  # GET /postcard_returns.json

  def stats
  end
  
  def index
    @postcard_returns = PostcardReturn.all
  end

  # GET /postcard_returns/1
  # GET /postcard_returns/1.json
  def show
  end

  # GET /postcard_returns/new
  def new
    @postcard_return = PostcardReturn.new
  end

  # GET /postcard_returns/1/edit
  def edit
  end

  # POST /postcard_returns
  # POST /postcard_returns.json
  def create
    @postcard_return = PostcardReturn.new(postcard_return_params)

    respond_to do |format|
      if @postcard_return.save
        format.html { redirect_to @postcard_return, notice: 'Postcard return was successfully created.' }
        format.json { render :show, status: :created, location: @postcard_return }
      else
        format.html { render :new }
        format.json { render json: @postcard_return.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postcard_returns/1
  # PATCH/PUT /postcard_returns/1.json
  def update
    respond_to do |format|
      if @postcard_return.update(postcard_return_params)
        format.html { redirect_to @postcard_return, notice: 'Postcard return was successfully updated.' }
        format.json { render :show, status: :ok, location: @postcard_return }
      else
        format.html { render :edit }
        format.json { render json: @postcard_return.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postcard_returns/1
  # DELETE /postcard_returns/1.json
  def destroy
    @postcard_return.destroy
    respond_to do |format|
      format.html { redirect_to postcard_returns_url, notice: 'Postcard return was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postcard_return
      @postcard_return = PostcardReturn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postcard_return_params
      params.require(:postcard_return).permit(:company, :postmark, :postcard, :uid, :reason)
    end
end
