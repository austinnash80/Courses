class SequoiaCustomerMatchesController < ApplicationController
  before_action :set_sequoia_customer_match, only: [:show, :edit, :update, :destroy]

  # GET /sequoia_customer_matches
  # GET /sequoia_customer_matches.json
  def index
    @sequoia_customer_matches = SequoiaCustomerMatch.all

    # if params['update'].present?
    #   SCustomer.first(50).each do |sequoia|
    #     MasterList.all.each do |master|
    #       if sequoia.lname == master.lname && master.lic == sequoia.lic_num
    #         new = SequoiaCustomerMatch.create(
    #           mid: master.lid + "CPA7/19",
    #           uid: sequoia.uid)
    #         new.save
    #       end
    #     end
    #   end
    #   redirect_to sequoia_customer_matches_path(update: 'done')
    # end

    if params['update'].present?
      SCustomer.last(100).each do |sequoia|
        old = SequoiaCustomerMatch.pluck(:uid)
        unless (sequoia.uid.to_s).include? old
        master = MasterList.where(lname: sequoia.lname).pluck(:lid)
          if master.blank?
            new = SequoiaCustomerMatch.create(
              uid: sequoia.uid)
          else master.present?
            new = SequoiaCustomerMatch.create(
              mid: master[0].to_s + 'cpa7/19',
              uid: sequoia.uid)
            new.save
          end
        end
        end
      redirect_to sequoia_customer_matches_path(done: 'yes')
    end

  end


  # GET /sequoia_customer_matches/1
  # GET /sequoia_customer_matches/1.json
  def show
  end

  # GET /sequoia_customer_matches/new
  def new
    @sequoia_customer_match = SequoiaCustomerMatch.new
  end

  # GET /sequoia_customer_matches/1/edit
  def edit
  end

  # POST /sequoia_customer_matches
  # POST /sequoia_customer_matches.json
  def create
    @sequoia_customer_match = SequoiaCustomerMatch.new(sequoia_customer_match_params)

    respond_to do |format|
      if @sequoia_customer_match.save
        format.html { redirect_to @sequoia_customer_match, notice: 'Sequoia customer match was successfully created.' }
        format.json { render :show, status: :created, location: @sequoia_customer_match }
      else
        format.html { render :new }
        format.json { render json: @sequoia_customer_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequoia_customer_matches/1
  # PATCH/PUT /sequoia_customer_matches/1.json
  def update
    respond_to do |format|
      if @sequoia_customer_match.update(sequoia_customer_match_params)
        format.html { redirect_to @sequoia_customer_match, notice: 'Sequoia customer match was successfully updated.' }
        format.json { render :show, status: :ok, location: @sequoia_customer_match }
      else
        format.html { render :edit }
        format.json { render json: @sequoia_customer_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequoia_customer_matches/1
  # DELETE /sequoia_customer_matches/1.json
  def destroy
    @sequoia_customer_match.destroy
    respond_to do |format|
      format.html { redirect_to sequoia_customer_matches_url, notice: 'Sequoia customer match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequoia_customer_match
      @sequoia_customer_match = SequoiaCustomerMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequoia_customer_match_params
      params.require(:sequoia_customer_match).permit(:mid, :uid, :match_date, :extra_s, :extra_i, :extra_b, :extra_d)
    end
end
