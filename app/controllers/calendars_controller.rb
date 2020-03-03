class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
    name
    form_collections
  end

  # GET /calendars/1/edit
  def edit
    name
    form_collections
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  def form_collections
    @people_1 = [['All',1], ['Kyle', 2], ['Austin',3], ['Michael',4], ['Ashley',5], ['Sabrina',6], ['John',7]]
    @people = ['All', 'Kyle', 'Austin', 'Michael', 'Ashley', 'Sabrina', 'John']
    @company = ['General', 'Sequoia', 'Empire', 'Taxpreparers']
    @reoccurring_rate = ['Daily', 'Weekly','Monthly']
  end

  def name
    user_signed_in? && current_user.email == 'austin@sequoiacpe.com' ? @name = 'Austin' : ''
    user_signed_in? && current_user.email == 'michael@sequoiacpe.com' ? @name = 'Michael' : ''
    user_signed_in? && current_user.email == 'kyle@sequoiacpe.com' ? @name = 'Kyle' : ''
    user_signed_in? && current_user.email == 'ashley@sequoiacpe.com' ? @name = 'Ashley' : ''
    user_signed_in? && current_user.email == 'sabrina@sequoiacpe.com' ? @name = 'Sabrina' : ''
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:event_date, :title, :details, :people, :creator, :reoccurring, :reoccurring_rate, :tag, :extra_d, :extra_i, :extra_s)
    end
end
