class MailingEmpireNmsController < ApplicationController
  before_action :set_mailing_empire_nm, only: [:show, :edit, :update, :destroy]

  # GET /mailing_empire_nms
  # GET /mailing_empire_nms.json
  def index

    @nm_total = MailingEmpireNm.all.count
    if params['last'].present?
      @nm_no_mail = MailingEmpireNm.where('lower(last) = ?', params['last'].downcase).order(:id).all
    end
    @export = MailingEmpireNm.all

    @id = EmpireCustomer.pluck(:id).max

    @nm_customers = EmpireCustomer.where(lic_state: 'NM')
    @customer_match = MailingEmpireNm.where(customer: true).all.count
    @customer_purchase = EmpireCustomer.where(lic_state: 'NM').pluck(:uid)
    @no_mails = MailingEmpireNm.where(no_mail: true).all.count


# MATCHING CUSTOMERS - HAPPENS Each time you load the page
    if params['run'] == 'customer'
      EmpireCustomer.where(lic_state: "NM").all.each do |i|
        MailingEmpireNm.where(customer: false).where(license_no: i.license_num).update_all customer: true
      end
      redirect_to mailing_empire_nms_path, notice: 'Customer Match Updated'
    end


     #     match = @nm_customers.where(license_num: i.license_no).pluck(:license_num)
     #     match.present? ? (MailingEmpireNm.where(license_no: match[0]).update_all customer: true) : ''
     # end

     # Delete Dups
     # id = EmpireCustomer.select("MIN(id) as id").group(:e_id).collect(&:id)
     # EmpireCustomer.where.not(id: id).destroy_all

     @nm_customer = EmpireCustomer.where(lic_state: 'NM').order('e_id DESC').all.count



# Buttom Filters
    if params['filter'].blank?
      @mailing_empire_nms = MailingEmpireNm.all.first(0)
    elsif params['filter'] == 'nov_25'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2019-12-31','2020-01-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'dec_16'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2020-01-31','2020-02-28']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'jan_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-02-28','2021-03-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'feb_17'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-03-31','2021-04-30']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'mar_16'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-04-30','2021-05-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'apr_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-05-31','2021-06-30']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'may_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-06-30','2021-07-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'jun_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-07-31','2021-08-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'jul_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-08-31','2021-09-30']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'aug_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-09-30','2021-10-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'sep_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-10-31','2021-11-30']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'oct_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-11-30','2021-12-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'nov_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-12-31','2022-01-31']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    elsif params['filter'] == 'dec_20'
      @mailing_empire_nms = MailingEmpireNm.where(expires: ['2021-01-31','2021-02-28']).where(licese_status: 'Active').where(dup_number: [1,nil]).where(customer: nil).where(no_mail: nil).order(:id).all
    end
# end Button Filters

    respond_to do |format|
      format.html
      format.csv { send_data @mailing_empire_nms.to_csv, filename: "NM_mailing_#{Date.today}.csv" }
    end

  end

  def data
    @id = EmpireCustomer.pluck(:e_id).max
  # MailingEmpireNm.where(last: "LUCERO").update_all middle: 'A'
  end

  # GET /mailing_empire_nms/1
  # GET /mailing_empire_nms/1.json
  def show
  end

  # GET /mailing_empire_nms/new
  def new
    @mailing_empire_nm = MailingEmpireNm.new
  end

  # GET /mailing_empire_nms/1/edit
  def edit
  end

  # POST /mailing_empire_nms
  # POST /mailing_empire_nms.json
  def create
    @mailing_empire_nm = MailingEmpireNm.new(mailing_empire_nm_params)

    respond_to do |format|
      if @mailing_empire_nm.save
        format.html { redirect_to @mailing_empire_nm, notice: 'Mailing empire nm was successfully created.' }
        format.json { render :show, status: :created, location: @mailing_empire_nm }
      else
        format.html { render :new }
        format.json { render json: @mailing_empire_nm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mailing_empire_nms/1
  # PATCH/PUT /mailing_empire_nms/1.json
  def update
    respond_to do |format|
      if @mailing_empire_nm.update(mailing_empire_nm_params)
        format.html { redirect_to @mailing_empire_nm, notice: 'Mailing empire nm was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailing_empire_nm }
      else
        format.html { render :edit }
        format.json { render json: @mailing_empire_nm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailing_empire_nms/1
  # DELETE /mailing_empire_nms/1.json
  def destroy
    @mailing_empire_nm.destroy
    respond_to do |format|
      format.html { redirect_to mailing_empire_nms_url, notice: 'Mailing empire nm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    MailingEmpireNm.my_import(params[:file])
    redirect_to mailing_empire_nms_path(page: 'nomail'), notice: "Upload Complete"
  end

  def remove_all
    MailingEmpireNm.delete_all
    flash[:notice] = "All Records Removed"
    redirect_to mailing_empire_nms_path
  end

  def no_mail
    MailingEmpireNm.where(id: params['id']).update_all no_mail: true
    redirect_to mailing_empire_nms_path(last: params['last']), notice: "NoMail Successful"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing_empire_nm
      @mailing_empire_nm = MailingEmpireNm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_empire_nm_params
      params.require(:mailing_empire_nm).permit(:list, :license_type, :name_prefix, :first, :middle, :last, :license_no, :add1, :add2, :city, :state, :zipcode, :county, :email, :licese_status, :issued, :expires, :last_renewal, :extra_s, :extra_i, :extra_b, :extra_d, :customer, :no_mail, :dup, :dup_number)
    end
end
