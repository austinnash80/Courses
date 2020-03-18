class EmpireCustomersController < ApplicationController
  # before_action :all_empire_customers, only: [:index, :create]
  before_action :set_empire_customer, only: [:show, :edit, :update, :destroy]
  # respond_to :html, :js

  # GET /empire_customers
  # GET /empire_customers.json
  def index
    run_data
    # @empire_customers_count = EmpireCustomer.all.count
    @empire_customers = EmpireCustomer.order(:e_id).last(1)
    @uids = EmpireCustomer.pluck(:uid)
    @id = '3'
    @total_purchases = EmpireCustomer.all.count
    customers = EmpireCustomer.all.pluck(:uid)
    @unique_customers = customers.uniq.count
    states = EmpireCustomer.all.pluck(:lic_state)
    @unique_states = states.uniq.count
    newest = EmpireCustomer.pluck(:e_id).max
    @last_update = EmpireCustomer.where(e_id: newest).pluck(:p_date)

# State Table
  @states = EmpireCustomer.all.group_by(&:lic_state)
  # @states = s.group_by{|h| h[:e_id]}.map{[k,v.size]}.to_hash
    if params['search'].present?
      @empire_customers_search = EmpireCustomer.where('lower(lname) = ?', params['search'].downcase).or(EmpireCustomer.where(uid: params['search']))
    end
  end

  def rc_marketing
    # NEW DEADLINE EXPORTS
    nc_exports
    pa_exports
    in_exports
    mo_b_exports

    if params['page'] == 'rolling' && params['what'] == 'email_new'
      rolling_emails
    end
    if params['page'] == 'rolling' && params['what'] == 'postcard_new'
      rolling_postcards
    end

end


#NEW EXPORTS
  def nc_exports
    state = params['state']
      # Find total list for each state
      # B_list is board list -> This mean they were match with the board data (they are still active) -> needs to be updated for what the new list is -> for now there is only one list so nil works
        if state == 'NC'
          @state_exp = '2020-06-10'.to_date
          # EMAIL
            full_1 = EmpireCustomer.where(lic_state: state).all
            # full_1 = EmpireCustomer.where(lic_state: state).where.not(b_list: nil).all
            id = []
            uid = []
            full_1.each do |nc|
              if uid.exclude?(nc.uid)
                id.push(nc.id)
                uid.push(nc.uid)
              end
            end
            @full_list = EmpireCustomer.where(id: id).all

            purchase_1 = EmpireCustomer.where(lic_state: state).where('p_date > ?', @state_exp - 11.months).all
            # purchase_1 = EmpireCustomer.where(lic_state: state).where('p_date > ?', @state_exp - 11.months).where(uid: uid).all
            id_purchase = []
            uid_purchase = []
            purchase_1.each do |nc|
              if uid_purchase.exclude?(nc.uid)
                id_purchase.push(nc.id)
                uid_purchase.push(nc.uid)
              end
            end
            @purchase_list = EmpireCustomer.where(id: id_purchase).all

            # ADD RECORDS TO THE EXPORT TABLE
            if params['add'] == 'full_list'
              state = params['state']
              PostcardExport.delete_all
              @full_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp,
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: 'NC', List: 'Full')
            end

            if params['add'] == 'purchase_list'
              state = params['state']
              PostcardExport.delete_all
              purchase_1.each do |empire_customer|
              # @purchase_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp,
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: 'NC', List: 'Purchase')
            end

            # POSTCARD
            @postcard_list = @full_list.where.not(uid: uid_purchase).all

            if params['add'] == 'postcard_list'
              state = params['state']
              PostcardExport.delete_all
              @postcard_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_postcard_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_1: '4-Hour North Carolina Package',
                  merge_2: 'Just $39.50',
                  merge_3: 'ReturningStudent20',
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'postcard', record: 'no', state: 'NC', List: 'Postcards', co: 'empire')
            end
        end
  end
  def pa_exports
    state = params['state']
      # Find total list for each state
      # B_list is board list -> This mean they were match with the board data (they are still active) -> needs to be updated for what the new list is -> for now there is only one list so nil works
        if state == 'PA'
          @state_exp = '2020-05-31'.to_date
          # EMAIL
            full_1 = EmpireCustomer.where(lic_state: state).where.not(b_list: nil).all
            id = []
            uid = []
            full_1.each do |nc|
              if uid.exclude?(nc.uid)
                id.push(nc.id)
                uid.push(nc.uid)
              end
            end
            @full_list = EmpireCustomer.where(id: id).all

            purchase_1 = EmpireCustomer.where(lic_state: state).where('p_date > ?', @state_exp - 22.months).where(uid: uid).all
            id_purchase = []
            uid_purchase = []
            purchase_1.each do |pa|
              if uid_purchase.exclude?(pa.uid)
                id_purchase.push(pa.id)
                uid_purchase.push(pa.uid)
              end
            end
            @purchase_list = EmpireCustomer.where(id: id_purchase).all

            # ADD RECORDS TO THE EXPORT TABLE
            if params['add'] == 'full_list'
              state = params['state']
              PostcardExport.delete_all
              @full_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: state, List: 'Full')
            end

            if params['add'] == 'purchase_list'
              state = params['state']
              PostcardExport.delete_all
              @purchase_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: state, List: 'Purchase')
            end

            # POSTCARD
            @postcard_list = @full_list.where.not(uid: uid_purchase).all

            if params['add'] == 'postcard_list'
              state = params['state']
              PostcardExport.delete_all
              @postcard_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_postcard_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_1: '16-Hour Pennsylvania Package',
                  merge_2: 'Just $64.50',
                  merge_3: 'ReturningStudent20',
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'postcard', record: 'no', state: state, List: 'Postcards', co: 'empire')
            end
        end
  end
  def in_exports
    state = params['state']
      # Find total list for each state
      # B_list is board list -> This mean they were match with the board data (they are still active) -> needs to be updated for what the new list is -> for now there is only one list so nil works
        if state == 'IN'
          @state_exp = '2020-06-30'.to_date
          # EMAIL
            full_1 = EmpireCustomer.where(lic_state: 'IND').where.not(b_list: nil).all
            id = []
            uid = []
            full_1.each do |ind|
              if uid.exclude?(ind.uid)
                id.push(ind.id)
                uid.push(ind.uid)
              end
            end
            @full_list = EmpireCustomer.where(id: id).all

            purchase_1 = EmpireCustomer.where(lic_state: 'IND').where('p_date > ?', @state_exp - 11.months).where(uid: uid).all
            id_purchase = []
            uid_purchase = []
            purchase_1.each do |ind|
              if uid_purchase.exclude?(ind.uid)
                id_purchase.push(ind.id)
                uid_purchase.push(ind.uid)
              end
            end
            @purchase_list = EmpireCustomer.where(id: id_purchase).all

            # ADD RECORDS TO THE EXPORT TABLE
            if params['add'] == 'full_list'
              state = params['state']
              PostcardExport.delete_all
              @full_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: state, List: 'Full')
            end

            if params['add'] == 'purchase_list'
              state = params['state']
              PostcardExport.delete_all
              @purchase_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: state, List: 'Purchase')
            end

            # POSTCARD
            @postcard_list = @full_list.where.not(uid: uid_purchase).all

            if params['add'] == 'postcard_list'
              state = params['state']
              PostcardExport.delete_all
              @postcard_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_postcard_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_1: '12-Hour Indiana Package',
                  merge_2: 'Just $49.50',
                  merge_3: 'ReturningStudent20',
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'postcard', record: 'no', state: state, List: 'Postcards', co: 'empire')
            end
        end
  end
  def mo_b_exports
    state = params['state']
      # Find total list for each state
      # B_list is board list -> This mean they were match with the board data (they are still active) -> needs to be updated for what the new list is -> for now there is only one list so nil works
        if state == 'MO_B'
          @state_exp = '2020-06-30'.to_date
          # EMAIL
            full_1 = EmpireCustomer.where(lic_state: 'MO').where.not(b_list: nil).all
            id = []
            uid = []
            full_1.each do |mo_b|
              if uid.exclude?(mo_b.uid)
                id.push(mo_b.id)
                uid.push(mo_b.uid)
              end
            end
            @full_list = EmpireCustomer.where(id: id).all

            purchase_1 = EmpireCustomer.where(lic_state: 'MO').where('p_date > ?', @state_exp - 22.months).where(uid: uid).all
            id_purchase = []
            uid_purchase = []
            purchase_1.each do |mo_b|
              if uid_purchase.exclude?(mo_b.uid)
                id_purchase.push(mo_b.id)
                uid_purchase.push(mo_b.uid)
              end
            end
            @purchase_list = EmpireCustomer.where(id: id_purchase).all

            # ADD RECORDS TO THE EXPORT TABLE
            if params['add'] == 'full_list'
              state = params['state']
              PostcardExport.delete_all
              @full_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: state, List: 'Full')
            end

            if params['add'] == 'purchase_list'
              state = params['state']
              PostcardExport.delete_all
              @purchase_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_email_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'email', record: 'no', state: state, List: 'Purchase')
            end

            # POSTCARD
            @postcard_list = @full_list.where.not(uid: uid_purchase).all

            if params['add'] == 'postcard_list'
              state = params['state']
              PostcardExport.delete_all
              @postcard_list.each do |empire_customer|
                new = PostcardExport.create(
                  company: 'Empire',
                  group: 'rc_postcard_deadline',
                  # mail_id: "",
                  # mail_id: "E-RC-Deadline-Email-Full",
                  mail_date: Date.today,
                  g_id: empire_customer.extra_s1,
                  license_number: empire_customer.license_num,
                  uid: empire_customer.uid,
                  exp: empire_customer.b_exp,
                  merge_1: '12-Hour Missouri Package',
                  merge_2: 'Just $59.50',
                  merge_3: 'ReturningStudent20',
                  merge_5: empire_customer.b_exp.strftime('%-m/%-d/%Y'),
                  f_name: empire_customer.fname,
                  l_name: empire_customer.lname,
                  add_1: empire_customer.street_1,
                  add_2: empire_customer.street_2,
                  city: empire_customer.city,
                  st: empire_customer.state,
                  zip: empire_customer.zip,
                  email: empire_customer.email)
                new.save
              end
                redirect_to postcard_exports_path(what:'postcard', record: 'no', state: state, List: 'Postcards', co: 'empire')
            end
        end
  end

  def rolling_postcards #In Use
    if params['ca'] == 'yes'
      rolling_states = ['CA']
      full_list = EmpireCustomer.where(lic_state: rolling_states).all
      id = []
      uid = []
      full_list.each do |empire_customer|
        if uid.exclude?(empire_customer.uid)
          id.push(empire_customer.id)
          uid.push(empire_customer.uid)
        end
      end
      @full_list_postcard = EmpireCustomer.where(id: id).all
      @ca_postcard_1 = []
      @ca_postcard_2 = []
      postcard_no = []
      @full_list_postcard.each do |empire_customer|
        if empire_customer.b_exp.present?
          if empire_customer.lic_state == 'CA'
            Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 60.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_postcard_1.push(empire_customer.id) :
            Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 30.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_postcard_2.push(empire_customer.id) :
            postcard_no.push(empire_customer.id)
          end
        end
      end

      @ca_postcard = @ca_postcard_1 + @ca_postcard_2

        PostcardExport.delete_all ## ONLY delete for CA(first) -> others are adding to the table
        @full_list_postcard.where(id: @ca_postcard).each do |empire_customer|
          new = PostcardExport.create(
            empire_customer_id: empire_customer.id,
            company: 'Empire',
            group: 'rc_rolling_postcard',
            list: empire_customer.b_list,
            mail_date: Date.today,
            send_date_s: Date.today.strftime('%-m/%-d/%Y'),
            license_number: empire_customer.license_num,
            uid: empire_customer.uid,
            exp: empire_customer.b_exp,
            exp_s: empire_customer.b_exp.blank? ? '' : empire_customer.b_exp.strftime('%-m/%-d/%Y'),
            merge_4: empire_customer.b_exp.blank? ? '' : "#{empire_customer.b_exp.strftime("%b")} #{empire_customer.b_exp.day.ordinalize}",
            f_name: empire_customer.fname,
            l_name: empire_customer.lname,
            add_1: empire_customer.street_1,
            add_2: empire_customer.street_2,
            city: empire_customer.city,
            st: empire_customer.state,
            zip: empire_customer.zip,
            email: empire_customer.email)
          new.save
        end

        ca_g1_merge_1 = '45-Hour California CE Package'
        ca_g1_merge_2 = '$49.00'
        ca_g1_merge_3 = 'ReturningStudent20'
        PostcardExport.where(empire_customer_id: (@ca_postcard_1 +  @ca_postcard_2)).update_all merge_1: ca_g1_merge_1, merge_2: ca_g1_merge_2, merge_3: ca_g1_merge_3

        ## Add Numbers to records
        new_record = PostcardRecord.create(
          company: 'empire',
          group: 'ca',
          mailing_id: "rolling_postcard-#{Date.today}",
          sent: (@ca_postcard_1 +  @ca_postcard_2).count)
          new_record.save

        redirect_to rc_marketing_empire_customers_path(page: 'rolling', what:'postcard_new', ca: 'done', ny: 'yes')

    end #params CA

    if params['ny'] == 'yes' #START NY
    rolling_states = ['NY']
    full_list = EmpireCustomer.where(lic_state: rolling_states).all
    id = []
    uid = []
    full_list.each do |empire_customer|
      if uid.exclude?(empire_customer.uid)
        id.push(empire_customer.id)
        uid.push(empire_customer.uid)
      end
    end
    @full_list_postcard = EmpireCustomer.where(id: id).all
    @ny_postcard_1 = []
    @ny_postcard_2 = []
    postcard_no = []
    @full_list_postcard.each do |empire_customer|
      if empire_customer.b_exp.present?
        if empire_customer.lic_state == 'NY'
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 60.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_postcard_1.push(empire_customer.id) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 30.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_postcard_2.push(empire_customer.id) :
          postcard_no.push(empire_customer.id)
        end
      end
    end

      @ny_postcard = @ny_postcard_1 + @ny_postcard_2

      @full_list_postcard.where(id: @ny_postcard).each do |empire_customer|
        new = PostcardExport.create(
          empire_customer_id: empire_customer.id,
          company: 'Empire',
          group: 'rc_rolling_postcard',
          list: empire_customer.b_list,
          mail_date: Date.today,
          send_date_s: Date.today.strftime('%-m/%-d/%Y'),
          license_number: empire_customer.license_num,
          uid: empire_customer.uid,
          exp: empire_customer.b_exp,
          exp_s: empire_customer.b_exp.blank? ? '' : empire_customer.b_exp.strftime('%-m/%-d/%Y'),
          merge_4: empire_customer.b_exp.blank? ? '' : "#{empire_customer.b_exp.strftime("%b")} #{empire_customer.b_exp.day.ordinalize}",
          f_name: empire_customer.fname,
          l_name: empire_customer.lname,
          add_1: empire_customer.street_1,
          add_2: empire_customer.street_2,
          city: empire_customer.city,
          st: empire_customer.state,
          zip: empire_customer.zip,
          email: empire_customer.email)
        new.save
      end

      ny_g1_merge_1 = '22.5-Hour California CE Package'
      ny_g1_merge_2 = '$59.50'
      ny_g1_merge_3 = 'ReturningStudent20'
      PostcardExport.where(empire_customer_id: (@ny_postcard_1 +  @ny_postcard_2)).update_all merge_1: ny_g1_merge_1, merge_2: ny_g1_merge_2, merge_3: ny_g1_merge_3

      ## Add Numbers to records
      new_record = PostcardRecord.create(
        company: 'empire',
        group: 'ny',
        mailing_id: "rolling_postcard-#{Date.today}",
        sent: (@ny_postcard_1 +  @ny_postcard_2).count)
        new_record.save

      redirect_to rc_marketing_empire_customers_path(page: 'rolling', what:'postcard_new', ca: 'done', ny: 'done', nm: 'yes')

  end #params NM
    if params['nm'] == 'yes' #START NY
    rolling_states = ['NM']
    full_list = EmpireCustomer.where(lic_state: rolling_states).all
    id = []
    uid = []
    full_list.each do |empire_customer|
      if uid.exclude?(empire_customer.uid)
        id.push(empire_customer.id)
        uid.push(empire_customer.uid)
      end
    end
    @full_list_postcard = EmpireCustomer.where(id: id).all
    @nm_postcard_1 = []
    @nm_postcard_2 = []
    postcard_no = []
    @full_list_postcard.each do |empire_customer|
      if empire_customer.b_exp.present?
        if empire_customer.lic_state == 'NM'
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 60.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_postcard_1.push(empire_customer.id) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 30.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_postcard_2.push(empire_customer.id) :
          postcard_no.push(empire_customer.id)
        end
      end
    end
    @nm_postcard = @nm_postcard_1 + @nm_postcard_2

      @full_list_postcard.where(id: @nm_postcard).each do |empire_customer| ## Add Records to EXPORT
        new = PostcardExport.create(
          empire_customer_id: empire_customer.id,
          company: 'Empire',
          group: 'rc_rolling_postcard',
          list: empire_customer.b_list,
          mail_date: Date.today,
          send_date_s: Date.today.strftime('%-m/%-d/%Y'),
          license_number: empire_customer.license_num,
          uid: empire_customer.uid,
          exp: empire_customer.b_exp,
          exp_s: empire_customer.b_exp.blank? ? '' : empire_customer.b_exp.strftime('%-m/%-d/%Y'),
          merge_4: empire_customer.b_exp.blank? ? '' : "#{empire_customer.b_exp.strftime("%b")} #{empire_customer.b_exp.day.ordinalize}",
          f_name: empire_customer.fname,
          l_name: empire_customer.lname,
          add_1: empire_customer.street_1,
          add_2: empire_customer.street_2,
          city: empire_customer.city,
          st: empire_customer.state,
          zip: empire_customer.zip,
          email: empire_customer.email)
        new.save
      end

      nm_g1_merge_1 = '24-Hour New Mexico CE Package' ##UPDATING the records that were just added with the correct 'MERGE' text
      nm_g1_merge_2 = '$155.50'
      nm_g1_merge_3 = 'ReturningStudent20'
      PostcardExport.where(empire_customer_id: (@nm_postcard_1 +  @nm_postcard_2)).update_all merge_1: nm_g1_merge_1, merge_2: nm_g1_merge_2, merge_3: nm_g1_merge_3

      new_record = PostcardRecord.create( ## Add Numbers to records
        company: 'empire',
        group: 'nm',
        mailing_id: "rolling_postcard-#{Date.today}",
        sent: (@nm_postcard_1 +  @nm_postcard_2).count)
        new_record.save

      redirect_to rc_marketing_empire_customers_path(page: 'rolling', what:'postcard_new', ca: 'done', ny: 'done', nm: 'done')
  end #params NY
end #def

  def rolling_emails # In USE
    if params['full_update'] == 'yes' ##ONLY when we need to add new customers to the list -> people are not mailed to till next cycle after purchase
      rolling_states = ['CA','NY','NM']

      full_list = EmpireCustomer.where(lic_state: rolling_states).where.not(b_exp: nil).all # FIND UNIQUE PEOPLE FROM CORRECT STATES
      # id = [] ## REMOVING DUPLICATED BY UID
      # uid = []
      # full_list.order(p_date: :desc).each do |empire_custer|
      #   if uid.exclude?(empire_custer.uid)
      #     id.push(empire_custer.id)
      #     uid.push(empire_custer.uid)
      #   end
      # end

      in_data_set = EmailExport.pluck(:empire_customer_id)
      full_list.where.not(id: in_data_set).each do |empire_customer|  #ADD all RECORDS TO THE POSTCARD EXPORT TABLE
        new = EmailExport.create(
          empire_customer_id: empire_customer.id,
          uid: empire_customer.uid,
          list: empire_customer.b_list,
          license_number: empire_customer.license_num,
          send_email: 'no',
          company: 'Empire',
          group: 'rc_rolling_email',
          send_date: Date.today,
          exp_b: empire_customer.b_exp.blank? ? '' : empire_customer.b_exp,
          # merge_4: empire_customer.b_exp.blank? ? '' : "#{empire_customer.b_exp.strftime("%b")} #{empire_customer.b_exp.day.ordinalize}",
          f_name: empire_customer.fname,
          l_name: empire_customer.lname,
          email: empire_customer.email)
        new.save
      end
      redirect_to rc_marketing_empire_customers_path(page: 'rolling', add: 'yes', what: 'email_new')
    end
    if params['ca'] == 'yes' ## ADD NY RECORDS -> UPDATE WITH SEND_MAIL
      EmailExport.update_all send_email: 'no' #RESET ALL RECORDS -> ONLY FOR California (first one)
      rolling_states = ['CA']
  #THIS IS DONE ABOVE WHEN ADDING RECORDS TO THE EMAIL EXPORT -> ADDDING ONLY UNIQUE PEOPLE (UID)
      full_list = EmpireCustomer.where(lic_state: rolling_states).where.not(b_exp: nil).all # FIND UNIQUE PEOPLE FROM CORRECT STATES
      id = []
      uid = []
      full_list.order(p_date: :desc).each do |empire_custer|
        if uid.exclude?(empire_custer.uid)
          id.push(empire_custer.id)
          uid.push(empire_custer.uid)
        end
      end
      @full_list = EmpireCustomer.where(id: id).all
      rolling_emails_dates_supplement #Function below that puts Lic Numbers into correct arrays

          rolling_emails_merge # merge fields update

          new_record = EmailRecord.create( ## Add Numbers to records
            company: 'empire',
            group: 'ca',
            mail_date: Date.today,
            mailing_id: "rolling_email-#{Date.today}",
            sent: (@ca).count)
            new_record.save
        redirect_to rc_marketing_empire_customers_path(page: 'rolling', what:'email_new', ca: 'done')
      end
    if params['ny'] == 'yes' ## ADD NY RECORDS -> UPDATE WITH SEND_MAIL
      rolling_states = ['NY']
      full_list = EmpireCustomer.where(lic_state: rolling_states).where.not(b_exp: nil).all # FIND UNIQUE PEOPLE FROM CORRECT STATES
      id = []
      uid = []
      full_list.order(p_date: :desc).each do |empire_custer|
        if uid.exclude?(empire_custer.uid)
          id.push(empire_custer.id)
          uid.push(empire_custer.uid)
        end
      end
      @full_list = EmpireCustomer.where(id: id).all

          rolling_emails_dates_supplement #Function below that puts Lic Numbers into correct arrays
          rolling_emails_merge # merge fields update

          new_record = EmailRecord.create( ## Add Numbers to records
            company: 'empire',
            group: 'ny',
            mail_date: Date.today,
            mailing_id: "rolling_email-#{Date.today}",
            sent: (@ny).count)
            new_record.save
        redirect_to rc_marketing_empire_customers_path(page: 'rolling', what:'email_new', ny: 'done')
      end
    if params['nm'] == 'yes'
      rolling_states = ['NM']
      full_list = EmpireCustomer.where(lic_state: rolling_states).all # FIND UNIQUE PEOPLE FROM CORRECT STATES
      id = []
      uid = []
      full_list.order(p_date: :desc).each do |empire_custer|
        if uid.exclude?(empire_custer.uid)
          id.push(empire_custer.id)
          uid.push(empire_custer.uid)
        end
      end
      @full_list = EmpireCustomer.where(id: id).where.not(b_exp: nil).all
      rolling_emails_dates_supplement #Function below that puts Lic Numbers into correct arrays

          rolling_emails_merge # merge fields update

          new_record = EmailRecord.create( ## Add Numbers to records
            company: 'empire',
            group: 'nm',
            mail_date: Date.today,
            mailing_id: "rolling_email-#{Date.today}",
            sent: (@nm).count)
            new_record.save
        redirect_to rc_marketing_empire_customers_path(page: 'rolling', what:'email_new', nm: 'done')
      end

  end

  def rolling_emails_merge # in use
    if params['ca'] == 'yes'
      ca_g1_subject = 'CA Early Bird Discount 15% Off' ## g1 = ca_email_1, ca_email_2, ca_email_3
      ca_g1_merge_1 = 'Get a head start on your CE requirements!'
      ca_g1_merge_2 = 'Please enjoy 15% off with discount code: Returning1520.'
      ca_g2_subject = 'CA Early Bird Discount 10% Off' ## g2 = ca_email_4, ca_email_5, ca_email_6, ca_email_7
      ca_g2_merge_1 = 'You still have time to take advantage of your early bird discount!'
      ca_g2_merge_2 = 'Please enjoy 10% off with discount code: Returning1020.'
      ca_g3_subject = 'Friendly reminder your CE credits are  almost due.' ## g3 = ca_email_8, ca_email_9
      ca_g3_merge_1 = 'The deadline to renew your CE requirments is approaching!'
      ca_g3_merge_2 =
      ca_g4_subject = 'CA Early Bird Discount 10% Off' ## g4 = ca_email_10, ca_email_10
      ca_g4_merge_1 = "Don't miss your CE deadline."
      ca_g4_merge_2 =
      ca_merge_3 = 'CA' ## Relevent for all CA
      ca_merge_5 = "California 45-Hour Full Renewal Package - $49"
      EmailExport.where(uid: (@ca_email_1 +  @ca_email_2 + @ca_email_3)).update_all send_email: 'yes', subject: ca_g1_subject, merge_1: ca_g1_merge_1, merge_2: ca_g1_merge_2, merge_3: ca_merge_3, merge_5: ca_merge_5
      EmailExport.where(uid: (@ca_email_4 +  @ca_email_5 + @ca_email_6 + @ca_email_7)).update_all send_email: 'yes', subject: ca_g2_subject, merge_1: ca_g2_merge_1, merge_2: ca_g2_merge_2, merge_3: ca_merge_3, merge_5: ca_merge_5
      EmailExport.where(uid: (@ca_email_8 +  @ca_email_9)).update_all send_email: 'yes', subject: ca_g3_subject, merge_1: ca_g3_merge_1, merge_3: ca_merge_3, merge_5: ca_merge_5
      EmailExport.where(uid: (@ca_email_10 +  @ca_email_11)).update_all send_email: 'yes', subject: ca_g4_subject, merge_1: ca_g4_merge_1, merge_3: ca_merge_3, merge_5: ca_merge_5
    end
    if params['ny'] == 'yes'
      ny_g1_subject = 'NY Early Bird Discount 15% Off' ## g1 = ny_email_1, ny_email_2, ny_email_3
      ny_g1_merge_1 = 'Get a head start on your CE requirements!'
      ny_g1_merge_2 = 'Please enjoy 15% off with discount code: Returning1520.'
      ny_g2_subject = 'NY Early Bird Discount 10% Off' ## g2 = ny_email_4, ny_email_5, ny_email_6, ny_email_7
      ny_g2_merge_1 = 'You still have time to take advantage of your early bird discount!'
      ny_g2_merge_2 = 'Please enjoy 10% off with discount code: Returning1020.'
      ny_g3_subject = 'Friendly reminder your CE credits are  almost due.' ## g3 = ny_email_8, ny_email_9
      ny_g3_merge_1 = 'The deadline to renew your CE requirments is approaching!'
      ny_g3_merge_2 =
      ny_g4_subject = 'NY Early Bird Discount 10% Off' ## g4 = ny_email_10, ny_email_10
      ny_g4_merge_1 = "Don't miss your CE deadline."
      ny_g4_merge_2 =
      ny_merge_3 = 'NY' ## Relevent for all NY
      ny_merge_5 = "New York 22.5-Hour Full Renewal Package - $59.50"
      EmailExport.where(uid: (@ny_email_1 +  @ny_email_2 + @ny_email_3)).update_all send_email: 'yes', subject: ny_g1_subject, merge_1: ny_g1_merge_1, merge_2: ny_g1_merge_2, merge_3: ny_merge_3, merge_5: ny_merge_5
      EmailExport.where(uid: (@ny_email_4 +  @ny_email_5 + @ny_email_6 + @ny_email_7)).update_all send_email: 'yes', subject: ny_g2_subject, merge_1: ny_g2_merge_1, merge_2: ny_g2_merge_2, merge_3: ny_merge_3, merge_5: ny_merge_5
      EmailExport.where(uid: (@ny_email_8 +  @ny_email_9)).update_all send_email: 'yes', subject: ny_g3_subject, merge_1: ny_g3_merge_1, merge_2: ny_g3_merge_2, merge_3: ny_merge_3, merge_5: ny_merge_5
      EmailExport.where(uid: (@ny_email_10 +  @ny_email_11)).update_all send_email: 'yes', subject: ny_g4_subject, merge_1: ny_g4_merge_1, merge_2: ny_g3_merge_2, merge_3: ny_merge_3, merge_5: ny_merge_5
    end
    if params['nm'] == 'yes'
      nm_g1_subject = 'NM Early Bird Discount 15% Off' ## g1 = nm_email_1, nm_email_2, nm_email_3
      nm_g1_merge_1 = 'Get a head start on your CE requirements!'
      nm_g1_merge_2 = 'Please enjoy 15% off with discount code: Returning1520.'
      nm_g2_subject = 'NM Early Bird Discount 10% Off' ## g2 = nm_email_4, nm_email_5, nm_email_6, nm_email_7
      nm_g2_merge_1 = 'You still have time to take advantage of your early bird discount!'
      nm_g2_merge_2 = 'Please enjoy 10% off with discount code: Returning1020.'
      nm_g3_subject = 'Friendly reminder your CE credits are  almost due.' ## g3 = nm_email_8, nm_email_9
      nm_g3_merge_1 = 'The deadline to renew your CE requirments is approaching!'
      nm_g3_merge_2 =
      nm_g4_subject = 'NM Early Bird Discount 10% Off' ## g4 = nm_email_10, nm_email_10
      nm_g4_merge_1 = "Don't miss your CE deadline."
      nm_g4_merge_2 =
      nm_merge_3 = 'NM' ## Relevent for all NM
      nm_merge_5 = "New Mexico 24-Hour Full Renewal Package - $159.50"
      EmailExport.where(uid: (@nm_email_1 +  @nm_email_2 +  @nm_email_3)).update_all send_email: 'yes', subject: nm_g1_subject, merge_1: nm_g1_merge_1, merge_2: nm_g1_merge_2, merge_3: nm_merge_3, merge_5: nm_merge_5
      EmailExport.where(uid: (@nm_email_4 +  @nm_email_5 +  @nm_email_6 +  @nm_email_7)).update_all send_email: 'yes', subject: nm_g2_subject, merge_1: nm_g2_merge_1, merge_2: nm_g2_merge_2, merge_3: nm_merge_3, merge_5: nm_merge_5
      EmailExport.where(uid: (@nm_email_8 +  @nm_email_9)).update_all send_email: 'yes', subject: nm_g3_subject, merge_1: nm_g3_merge_1, merge_2: nm_g3_merge_2, merge_3: nm_merge_3, merge_5: nm_merge_5
      EmailExport.where(uid: (@nm_email_10 +  @nm_email_11)).update_all send_email: 'yes', subject: nm_g4_subject, merge_1: nm_g4_merge_1, merge_2: nm_g3_merge_2, merge_3: nm_merge_3, merge_5: nm_merge_5
    end
  end

  def rolling_emails_dates_supplement #in use
    if params['ca'] == 'yes'
      @ca_email_1 = []
      @ca_email_2 = []
      @ca_email_3 = []
      @ca_email_4 = []
      @ca_email_5 = []
      @ca_email_6 = []
      @ca_email_7 = []
      @ca_email_8 = []
      @ca_email_9 = []
      @ca_email_10 = []
      @ca_email_11 = []
      email_no = []
      @full_list.where(lic_state: 'CA').each do |empire_customer|
        if empire_customer.b_exp.present?
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 180.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_1.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 150.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_2.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 120.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_3.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 90.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_4.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 60.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_5.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 45.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 30.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 15.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 10.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 5.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 2.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ca_email_6.push(empire_customer.uid) :
          email_no.push(empire_customer.id)
        end
      end
      @ca = @ca_email_1 + @ca_email_2 + @ca_email_3 + @ca_email_4 + @ca_email_5 + @ca_email_6 + @ca_email_7 + @ca_email_8 + @ca_email_9 + @ca_email_10 + @ca_email_11
      @no = email_no
    end
    if params['ny'] == 'yes'
      @ny_email_1 = []
      @ny_email_2 = []
      @ny_email_3 = []
      @ny_email_4 = []
      @ny_email_5 = []
      @ny_email_6 = []
      @ny_email_7 = []
      @ny_email_8 = []
      @ny_email_9 = []
      @ny_email_10 = []
      @ny_email_11 = []
      email_no = []
      @full_list.where(lic_state: 'NY').each do |empire_customer|
        if empire_customer.b_exp.present?
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 180.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_1.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 150.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_2.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 120.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_3.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 90.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_4.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 60.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_5.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 45.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 30.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 15.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 10.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 5.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 2.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @ny_email_6.push(empire_customer.uid) :
          email_no.push(empire_customer.id)
        end
      end
      @ny = @ny_email_1 + @ny_email_2 + @ny_email_3 + @ny_email_4 + @ny_email_5 + @ny_email_6 + @ny_email_7 + @ny_email_8 + @ny_email_9 + @ny_email_10 + @ny_email_11
      @no = email_no
    end
    if params['nm'] == 'yes'
      @nm_email_1 = []
      @nm_email_2 = []
      @nm_email_3 = []
      @nm_email_4 = []
      @nm_email_5 = []
      @nm_email_6 = []
      @nm_email_7 = []
      @nm_email_8 = []
      @nm_email_9 = []
      @nm_email_10 = []
      @nm_email_11 = []
      email_no = []
      @full_list.where(lic_state: 'NM').each do |empire_customer|
        if empire_customer.b_exp.present?
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 180.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_1.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 150.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_2.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 120.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_3.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 90.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_4.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 60.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_5.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 45.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 30.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 15.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 10.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 5.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_6.push(empire_customer.uid) :
          Date.today.at_beginning_of_week.strftime('%Y-%m-%d') == (empire_customer.b_exp.to_date - 2.days).at_beginning_of_week.strftime('%Y-%m-%d') ? @nm_email_6.push(empire_customer.uid) :
          email_no.push(empire_customer.id)
        end
      end
      @nm = @nm_email_1 + @nm_email_2 + @nm_email_3 + @nm_email_4 + @nm_email_5 + @nm_email_6 + @nm_email_7 + @nm_email_8 + @nm_email_9 + @nm_email_10 + @nm_email_11
      @no = email_no
    end

  end

  def b_exp
    if params['state'].present? && params['state'] != 'MO_B'
      lic = EmpireCustomer.where(lic_state: params['state']).where(b_exp: nil).pluck(:license_num)
      EmpireMasterList.where(source: params['state']).where(license_number: lic).each do |master|
        EmpireCustomer.where(lic_state: params['state']).where(b_exp: nil).where(license_num: master.license_number).update_all b_exp: master.exp_date, b_list: master.list, empire_master_list_id: master.id
      end
    elsif params['state'] == 'MO_B'
      lic = EmpireCustomer.where(lic_state: 'MO').where(b_exp: nil).pluck(:license_num)
      EmpireMasterList.where(source: 'MO_B').where(license_number: lic).each do |master|
        EmpireCustomer.where(lic_state: 'MO').where(b_exp: nil).where(license_num: master.license_number).update_all b_exp: master.exp_date, b_list: master.list, empire_master_list_id: master.id
      end
    end
    redirect_to empire_master_lists_path, notice: "#{params['state']} Update Complete"
  end

  def run_data
    if params['e_id'].present?
      # if params['e_id'].to_i > EmpireCustomer.all.pluck(:e_id).max
          new = EmpireCustomer.create(
            e_id: params['e_id'].present? ? params['e_id'].to_i : 0,
            uid: params['uid'],
            license_num: params['license_num'],
            existing: params['existing'],
            p_date: params['purchase_date'].present? ? Date::strptime(params['purchase_date'],"%m/%d/%y") : '',
            purchase_date: params['purchase_date'],
            lic_state: params['lic_state'],
            products: params['products'],
            total: params['order_total'].present? ? params['order_total'].to_f : 0,
            order_total: params['order_total'],
            fname: params['fname'],
            lname: params['lname'],
            company: params['company'],
            city: params['city'],
            state: params['state'],
            zip: params['zip'],
            email: params['email'],
            phone: params['phone'],
            street_1: params['street_1'],
            street_2: params['street_2']
          )
          new.save

        redirect_to data_mailing_empire_nms_path
    end
  end

  # GET /empire_customers/1
  # GET /empire_customers/1.json
  def show
  end

  # GET /empire_customers/new
  def new
    @empire_customer = EmpireCustomer.new
  end

  # GET /empire_customers/1/edit
  def edit
  end

  # POST /empire_customers
  # POST /empire_customers.json
  def create
    @empire_customer = EmpireCustomer.new(empire_customer_params)

    respond_to do |format|
      if @empire_customer.save
        format.html { redirect_to @empire_customer, notice: 'Empire customer was successfully created.' }
        format.json { render :show, status: :created, location: @empire_customer }
      else
        format.html { render :new }
        format.json { render json: @empire_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empire_customers/1
  # PATCH/PUT /empire_customers/1.json
  def update
    respond_to do |format|
      if @empire_customer.update(empire_customer_params)
        format.html { redirect_to @empire_customer, notice: 'Empire customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @empire_customer }
      else
        format.html { render :edit }
        format.json { render json: @empire_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empire_customers/1
  # DELETE /empire_customers/1.json
  def destroy
    @empire_customer.destroy
    respond_to do |format|
      format.html { redirect_to empire_customers_url, notice: 'Empire customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import #Uploading CSV function
    EmpireCustomer.my_import(params[:file])
    redirect_to empire_customers_path, notice: "Upload Complete"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empire_customer
      @empire_customer = EmpireCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empire_customer_params
      params.require(:empire_customer).permit(:e_id, :uid, :license_num, :existing, :purchase_date, :lic_state, :products, :order_total, :fname, :lname, :company, :street_1, :street_2, :city, :state, :zip, :email, :phone, :p_date, :total, :b_exp, :b_list, :empire_master_list_id, :extra_s1, :extra_s2, :extra_i, :extra_b, :empire_customer_id)
    end
end
