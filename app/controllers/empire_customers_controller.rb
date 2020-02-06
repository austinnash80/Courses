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
    if params['page'] == 'deadline'
      rc_marketing_deadline
    end
    if params['page'] == 'rolling' && params['what'] == 'email'
      re_marketing_rolling_email
    end
    rc_marketing_date
    rc_marketing_states
    if params['what'] == 'postcard'
    @ca_master_1 = EmpireMasterList.where(source: 'CA').where(license_number: @ca_1).where.not(license_number: @ca_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number)
    @ca_master_2 = EmpireMasterList.where(source: 'CA').where(license_number: @ca_1).where.not(license_number: @ca_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number)
    @ny_master_1 = EmpireMasterList.where(source: 'NY').where(license_number: @ny_1).where.not(license_number: @ny_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number)
    @ny_master_2 = EmpireMasterList.where(source: 'NY').where(license_number: @ny_1).where.not(license_number: @ny_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number)
    @nm_master_1 = EmpireMasterList.where(source: 'NM').where(license_number: @nm_1).where.not(license_number: @nm_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @nm_master_2 = EmpireMasterList.where(source: 'NM').where(license_number: @nm_1).where.not(license_number: @nm_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @ut_master_1 = EmpireMasterList.where(source: 'UT').where(license_number: @ut_1).where.not(license_number: @ut_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @ut_master_2 = EmpireMasterList.where(source: 'UT').where(license_number: @ut_1).where.not(license_number: @ut_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second
    @wa_master_1 = EmpireMasterList.where(source: 'WA').where(license_number: @wa_1).where.not(license_number: @wa_2).where('exp_date >= ? AND exp_date <= ?', @date_1a, @date_1b).pluck(:license_number)#all NM That meet the date criteria, and match the first array but no the second
    @wa_master_2 = EmpireMasterList.where(source: 'WA').where(license_number: @wa_1).where.not(license_number: @wa_2).where('exp_date >= ? AND exp_date <= ?', @date_2a, @date_2b).pluck(:license_number) #all NM That meet the date criteria, and match the first array but no the second

    @exp_1 = @ca_master_1.count + @ny_master_1.count + @nm_master_1.count + @ut_master_1.count + @wa_master_1.count
    @exp_2 = @ca_master_2.count + @ny_master_2.count + @nm_master_2.count + @ut_master_2.count + @wa_master_2.count
    # @export_1 = @ca_master_1.union(@ca_master_2)
    # @export_1 = @ca_master_1.union(@ca_master_2).union(@ny_master_1).union(@ny_master_2).union(@nm_master_1).union(@nm_master_2).union(@ut_master_1).union(@ut_master_2).union(@wa_master_1).union(@wa_master_2)
    # @export_2 = EmpireCustomer.where(license_num: ca_export).where(lic_state: 'CA').all

    # @export = @ca_master_1.or(@ca_master_2).or(@ny_master_1).or(@ny_master_2).or(@nm_master_1).or(@nm_master_2).or(@ut_master_1).or(@ut_master_2).or(@wa_master_1).or(@wa_master_2)
    @empire_purchases = EmpireCustomer.all
    @empire_customers = EmpireCustomer.pluck(:uid).uniq

      if params['added'] == 'done'
          PostcardExport.delete_all #Delete all the current records - fresh database each time.
        ### CA
        ca_export = @ca_master_1.union(@ca_master_2)
        ca_empire = EmpireCustomer.where(lic_state: 'CA').where(license_num: ca_export).all
        ca_license_number = []

        ca_empire.each do |empire_customer|
          if ca_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-Rolling-Postcard-#{params['day']}",
              mail_date: params['day'],
              state: 'CA',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: '45-Hour California Full Renewal Package',
              merge_2: 'Just $49',
              merge_3: 'ReturningStudent20',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            ca_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end

        ### NY
        ny_export = @ny_master_1.union(@ny_master_2)
        ny_empire = EmpireCustomer.where(lic_state: 'NY').where(license_num: ny_export).all
        ny_license_number = []

        ny_empire.each do |empire_customer|
          if ny_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-Rolling-Postcard-#{params['day']}",
              mail_date: params['day'],
              state: 'NY',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: '22.5-Hour New York Package',
              merge_2: 'Just $59.50',
              merge_3: 'ReturningStudent20',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            ny_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end
        ### NM
        nm_export = @nm_master_1.union(@nm_master_2)
        nm_empire = EmpireCustomer.where(lic_state: 'NM').where(license_num: nm_export).all
        nm_license_number = []

        nm_empire.each do |empire_customer|
          if nm_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-Rolling-Postcard-#{params['day']}",
              mail_date: params['day'],
              state: 'NM',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            nm_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end
        ### UT
        ut_export = @ut_master_1.union(@ut_master_2)
        ut_empire = EmpireCustomer.where(lic_state: 'UT').where(license_num: ut_export).all
        ut_license_number = []

        ut_empire.each do |empire_customer|
          if ut_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-Rolling-Postcard-#{params['day']}",
              mail_date: params['day'],
              state: 'UT',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            ut_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end
        ### WA
        wa_export = @wa_master_1.union(@wa_master_2)
        wa_empire = EmpireCustomer.where(lic_state: 'WA').where(license_num: wa_export).all
        wa_license_number = []

        wa_empire.each do |empire_customer|
          if wa_license_number.exclude? empire_customer.license_num
            new = PostcardExport.create(
              company: 'Empire',
              group: 'rc postcard',
              mail_id: "E-RC-Rolling-Postcard-#{params['day']}",
              mail_date: params['day'],
              state: 'WA',
              license_number: empire_customer.license_num,
              uid: empire_customer.uid,
              merge_1: 'Merge Text 1',
              merge_2: 'Merge Text 1',
              merge_3: 'Merge Text 1',
              f_name: empire_customer.fname,
              l_name: empire_customer.lname,
              add_1: empire_customer.street_1,
              add_2: empire_customer.street_2,
              city: empire_customer.city,
              st: empire_customer.state,
              zip: empire_customer.zip,
              email: empire_customer.email)
            new.save
            wa_license_number.push(empire_customer.license_num) #Push new records lic number in to array to not allow duplicates in new table
          end
        end

        redirect_to postcard_exports_path(co: 'empire', group: 'rc postcard', mail_id: "E-RC-Rolling-Postcard-#{params['day']}", day: params['day'], card: 'postcard standard', sent: @exp_1 + @exp_2)
      end
      end #If 'data'

  end

  def rc_marketing_date
      if params['day'].present?
        @mail_day = params['day'].to_date
        @date_1a = ((@mail_day + 33.days).to_date).at_beginning_of_week
        @date_1b = ((@mail_day + 33.days).to_date).at_end_of_week
        @date_2a = ((@mail_day + 63.days).to_date).at_beginning_of_week
        @date_2b = ((@mail_day + 63.days).to_date).at_end_of_week
      end
  end

  def rc_marketing_states

    #Monthly Expiration States
      ca = EmpireCustomer.where(lic_state: 'CA').all #All NM Customers
      @ca_1 = ca.pluck(:license_num).uniq #Array of all unique license numbers
      @ca_2 = ca.where('p_date >= ?', Date.today - 30.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      ny = EmpireCustomer.where(lic_state: 'NY').all #All NM Customers
      @ny_1 = ny.pluck(:license_num).uniq #Array of all unique license numbers
      @ny_2 = ny.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      nm = EmpireCustomer.where(lic_state: 'NM').all #All NM Customers
      @nm_1 = nm.pluck(:license_num).uniq #Array of all unique license numbers
      @nm_2 = nm.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      ut = EmpireCustomer.where(lic_state: 'UT').all #All NM Customers
      @ut_1 = ut.pluck(:license_num).uniq #Array of all unique license numbers
      @ut_2 = ut.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame
      wa = EmpireCustomer.where(lic_state: 'WA').all #All NM Customers
      @wa_1 = wa.pluck(:license_num).uniq #Array of all unique license numbers
      @wa_2 = wa.where('p_date >= ?', Date.today - 18.months).pluck(:license_num).uniq #Array of unique license number who have purchases in the given time frame

  end

  def re_marketing_rolling_email

## DAYS
     day = params['day'].to_date
      g1_day_a = ((day + 180.days).to_date).at_beginning_of_week
      g1_day_b = ((day + 180.days).to_date).at_end_of_week
      g2_day_a = ((day + 150.days).to_date).at_beginning_of_week
      g2_day_b = ((day + 150.days).to_date).at_end_of_week
      g3_day_a = ((day + 120.days).to_date).at_beginning_of_week
      g3_day_b = ((day + 120.days).to_date).at_end_of_week
      g4_day_a = ((day + 90.days).to_date).at_beginning_of_week
      g4_day_b = ((day + 90.days).to_date).at_end_of_week
      g5_day_a = ((day + 60.days).to_date).at_beginning_of_week
      g5_day_b = ((day + 60.days).to_date).at_end_of_week
      g6_day_a = ((day + 45.days).to_date).at_beginning_of_week
      g6_day_b = ((day + 45.days).to_date).at_end_of_week
      g7_day_a = ((day + 30.days).to_date).at_beginning_of_week
      g7_day_b = ((day + 30.days).to_date).at_end_of_week
      g8_day_a = ((day + 15.days).to_date).at_beginning_of_week
      g8_day_b = ((day + 15.days).to_date).at_end_of_week
      g9_day_a = ((day + 10.days).to_date).at_beginning_of_week
      g9_day_b = ((day + 10.days).to_date).at_end_of_week
      g10_day_a = ((day + 5.days).to_date).at_beginning_of_week
      g10_day_b = ((day + 5.days).to_date).at_end_of_week
      g11_day_a = ((day + 2.days).to_date).at_beginning_of_week
      g11_day_b = ((day + 2.days).to_date).at_end_of_week
## DAYS END

## GROUP ARRAYS
      g1_ca = []
      g2_ca = []
      g3_ca = []
      g4_ca = []
      g5_ca = []
      g6_ca = []
      g7_ca = []
      g8_ca = []
      g9_ca = []
      g10_ca = []
      g11_ca = []
      g1_ny = []
      g2_ny = []
      g3_ny = []
      g4_ny = []
      g5_ny = []
      g6_ny = []
      g7_ny = []
      g8_ny = []
      g9_ny = []
      g10_ny = []
      g11_ny = []
      g1_nm = []
      g2_nm = []
      g3_nm = []
      g4_nm = []
      g5_nm = []
      g6_nm = []
      g7_nm = []
      g8_nm = []
      g9_nm = []
      g10_nm = []
      g11_nm = []
## GROUP ARRAYS END

## Master Vaiables
      ca_customer = EmpireCustomer.where(lic_state: 'CA').all
      ny_customer = EmpireCustomer.where(lic_state: 'NY').all
      nm_customer = EmpireCustomer.where(lic_state: 'NM').all
      ca_master = EmpireMasterList.where(source: 'CA')
      ny_master = EmpireMasterList.where(source: 'NY')
      nm_master = EmpireMasterList.where(source: 'NM')
## Master Vaiables END

## GROUPS BY LICENSE NUMBER
    g1_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g1_day_a, g1_day_b).pluck(:license_number)
    g2_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g2_day_a, g2_day_b).pluck(:license_number)
    g3_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g3_day_a, g3_day_b).pluck(:license_number)
    g4_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g4_day_a, g4_day_b).pluck(:license_number)
    g5_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g5_day_a, g5_day_b).pluck(:license_number)
    g6_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g6_day_a, g6_day_b).pluck(:license_number)
    g7_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g7_day_a, g7_day_b).pluck(:license_number)
    g8_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g8_day_a, g8_day_b).pluck(:license_number)
    g9_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g9_day_a, g9_day_b).pluck(:license_number)
    g10_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g10_day_a, g10_day_b).pluck(:license_number)
    g11_ca_master = ca_master.where('exp_date > ? AND exp_date <= ?', g11_day_a, g11_day_b).pluck(:license_number)
    g1_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g1_day_a, g1_day_b).pluck(:license_number)
    g2_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g2_day_a, g2_day_b).pluck(:license_number)
    g3_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g3_day_a, g3_day_b).pluck(:license_number)
    g4_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g4_day_a, g4_day_b).pluck(:license_number)
    g5_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g5_day_a, g5_day_b).pluck(:license_number)
    g6_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g6_day_a, g6_day_b).pluck(:license_number)
    g7_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g7_day_a, g7_day_b).pluck(:license_number)
    g8_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g8_day_a, g8_day_b).pluck(:license_number)
    g9_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g9_day_a, g9_day_b).pluck(:license_number)
    g10_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g10_day_a, g10_day_b).pluck(:license_number)
    g11_ny_master = ny_master.where('exp_date > ? AND exp_date <= ?', g11_day_a, g11_day_b).pluck(:license_number)
    g1_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g1_day_a, g1_day_b).pluck(:license_number)
    g2_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g2_day_a, g2_day_b).pluck(:license_number)
    g3_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g3_day_a, g3_day_b).pluck(:license_number)
    g4_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g4_day_a, g4_day_b).pluck(:license_number)
    g5_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g5_day_a, g5_day_b).pluck(:license_number)
    g6_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g6_day_a, g6_day_b).pluck(:license_number)
    g7_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g7_day_a, g7_day_b).pluck(:license_number)
    g8_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g8_day_a, g8_day_b).pluck(:license_number)
    g9_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g9_day_a, g9_day_b).pluck(:license_number)
    g10_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g10_day_a, g10_day_b).pluck(:license_number)
    g11_nm_master = nm_master.where('exp_date > ? AND exp_date <= ?', g11_day_a, g11_day_b).pluck(:license_number)
## GROUPS END

## EXCLUDES (custers who have already purchased for this renewal cycle)
    ca_exclude = ca_customer.where('p_date > ?', Date.today - 2.year).pluck(:uid)
    ny_exclude = ny_customer.where('p_date > ?', Date.today - 1.year).pluck(:uid)
    nm_exclude = nm_customer.where('p_date > ?', Date.today - 1.year).pluck(:uid)
## EXCLUDES END

## ADDING TO GROUP ARRAY
  #CA
     ca_customer.each do |empire_customer|
       if g1_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g1_ca.push(empire_customer.uid)
       elsif g2_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g2_ca.push(empire_customer.uid)
       elsif g3_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g3_ca.push(empire_customer.uid)
       elsif g4_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g4_ca.push(empire_customer.uid)
       elsif g5_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g5_ca.push(empire_customer.uid)
       elsif g6_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g6_ca.push(empire_customer.uid)
       elsif g7_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g7_ca.push(empire_customer.uid)
       elsif g8_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g8_ca.push(empire_customer.uid)
       elsif g9_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g9_ca.push(empire_customer.uid)
       elsif g10_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g10_ca.push(empire_customer.uid)
       elsif g11_ca_master.include?(empire_customer.license_num) && ca_exclude.exclude?(empire_customer.uid)
         g11_ca.push(empire_customer.uid)
       end
     end
  #NY
   ny_customer.each do |empire_customer|
     if g1_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g1_ny.push(empire_customer.uid)
     elsif g2_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g2_ny.push(empire_customer.uid)
     elsif g3_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g3_ny.push(empire_customer.uid)
     elsif g4_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g4_ny.push(empire_customer.uid)
     elsif g5_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g5_ny.push(empire_customer.uid)
     elsif g6_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g6_ny.push(empire_customer.uid)
     elsif g7_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g7_ny.push(empire_customer.uid)
     elsif g8_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g8_ny.push(empire_customer.uid)
     elsif g9_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g9_ny.push(empire_customer.uid)
     elsif g10_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g10_ny.push(empire_customer.uid)
     elsif g11_ny_master.include?(empire_customer.license_num) && ny_exclude.exclude?(empire_customer.uid)
       g11_ny.push(empire_customer.uid)
     end
   end
  #NM
   nm_customer.each do |empire_customer|
     if g1_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g1_nm.push(empire_customer.uid)
     elsif g2_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g2_nm.push(empire_customer.uid)
     elsif g3_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g3_nm.push(empire_customer.uid)
     elsif g4_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g4_nm.push(empire_customer.uid)
     elsif g5_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g5_nm.push(empire_customer.uid)
     elsif g6_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g6_nm.push(empire_customer.uid)
     elsif g7_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g7_nm.push(empire_customer.uid)
     elsif g8_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g8_nm.push(empire_customer.uid)
     elsif g9_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g9_nm.push(empire_customer.uid)
     elsif g10_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g10_nm.push(empire_customer.uid)
     elsif g11_nm_master.include?(empire_customer.license_num) && nm_exclude.exclude?(empire_customer.uid)
       g11_nm.push(empire_customer.uid)
     end
   end
 ## ADDING END

## TOTALS
groups_ca = [ g1_ca, g2_ca , g3_ca , g4_ca , g5_ca , g6_ca , g7_ca , g8_ca , g9_ca , g10_ca , g11_ca]
groups_ny = [ g1_ny, g2_ny , g3_ny , g4_ny , g5_ny , g6_ny , g7_ny , g8_ny , g9_ny , g10_ny , g11_ny]
groups_nm = [ g1_nm, g2_nm , g3_nm , g4_nm , g5_nm , g6_nm , g7_nm , g8_nm , g9_nm , g10_nm , g11_nm]
@ca_count = []
ca_uid = []
@ny_count = []
ny_uid = []
@nm_count = []
nm_uid = []
groups_ca.each do |i| @ca_count.push(i.uniq.count)
  i.each do |uid|
    ca_uid.push(uid)
  end
end
groups_ny.each do |i| @ny_count.push(i.uniq.count)
  i.each do |uid|
    ny_uid.push(uid)
  end
end
groups_nm.each do |i| @nm_count.push(i.uniq.count)
  i.each do |uid|
    nm_uid.push(uid)
  end
end


# #ADD
  if params['added'] == 'done'

    PostcardExport.delete_all #Delete all the current records - fresh database each time.

    added_ca_uid = []
    ca_customer.each do |empire_customer|
      if ca_uid.include? empire_customer.uid
        unless added_ca_uid.include? empire_customer.uid
          new = PostcardExport.create(
            company: 'Empire',
            group: 'rc email',
            mail_id: "E-RC-Rolling-Email-#{params['day']}",
            mail_date: params['day'],
            state: 'CA',
            license_number: empire_customer.license_num,
            uid: empire_customer.uid,
            merge_1: 'Merge Text 1',
            merge_2: 'Merge Text 1',
            merge_3: 'Merge Text 1',
            f_name: empire_customer.fname,
            l_name: empire_customer.lname,
            add_1: empire_customer.street_1,
            add_2: empire_customer.street_2,
            city: empire_customer.city,
            st: empire_customer.state,
            zip: empire_customer.zip,
            email: empire_customer.email)
          new.save
          added_ca_uid.push(empire_customer.uid) #Push new records lic number in to array to not allow duplicates in new table
        end
      end
    end
    added_ny_uid = []
    ny_customer.each do |empire_customer|
      if ny_uid.include? empire_customer.uid
        unless added_ny_uid.include? empire_customer.uid
          new = PostcardExport.create(
            company: 'Empire',
            group: 'rc email',
            mail_id: "E-RC-Rolling-Email-#{params['day']}",
            mail_date: params['day'],
            state: 'NY',
            license_number: empire_customer.license_num,
            uid: empire_customer.uid,
            merge_1: 'Merge Text 1',
            merge_2: 'Merge Text 1',
            merge_3: 'Merge Text 1',
            f_name: empire_customer.fname,
            l_name: empire_customer.lname,
            add_1: empire_customer.street_1,
            add_2: empire_customer.street_2,
            city: empire_customer.city,
            st: empire_customer.state,
            zip: empire_customer.zip,
            email: empire_customer.email)
          new.save
          added_ny_uid.push(empire_customer.uid) #Push new records lic number in to array to not allow duplicates in new table
        end
      end
    end
    added_nm_uid = []
    nm_customer.each do |empire_customer|
      if nm_uid.include? empire_customer.uid
        unless added_nm_uid.include? empire_customer.uid
          new = PostcardExport.create(
            company: 'Empire',
            group: 'rc email',
            mail_id: "E-RC-Rolling-Email-#{params['day']}",
            mail_date: params['day'],
            state: 'NM',
            license_number: empire_customer.license_num,
            uid: empire_customer.uid,
            merge_1: 'Merge Text 1',
            merge_2: 'Merge Text 1',
            merge_3: 'Merge Text 1',
            f_name: empire_customer.fname,
            l_name: empire_customer.lname,
            add_1: empire_customer.street_1,
            add_2: empire_customer.street_2,
            city: empire_customer.city,
            st: empire_customer.state,
            zip: empire_customer.zip,
            email: empire_customer.email)
          new.save
          added_nm_uid.push(empire_customer.uid) #Push new records lic number in to array to not allow duplicates in new table
        end
      end
    end

    redirect_to postcard_exports_path(co: 'empire', group: 'rc email', mail_id: "E-RC-Rolling-Email-#{params['day']}", day: params['day'], what: params['what'], card: 'email', sent: @ca_count.sum+@ny_count.sum+@nm_count.sum)

  end


## TOTALS END

  end

  def rc_marketing_deadline
    # All who have not purchased in the last x time - match with board list ?
    if params['state'] == 'PA'
      pa_exp = '2020-05-31'.to_date
      company = 'empire'
      mail_date = params['day']
      state = 'PA'
      if params['type'] == 'email'
        mail_id = "E-RC-Deadline-PA-Email-#{mail_date}"
        group = 'rc email'
        merge_1 = 'merge 1 - email'
        merge_2 = 'merge 2 - email'
        merge_3 = 'merge 3 - email'
      end
      if params['type'] == 'postcard'
        mail_id = "E-RC-Deadline-PA-Postcard-#{mail_date}"
        group = 'rc postcard'
        merge_1 = 'test 1 - postcard'
        merge_2 = 'test 2 - postcard'
        merge_3 = 'test 3 - postcard'
      end
      current = EmpireCustomer.where(lic_state: 'PA').where('p_date >= ?', pa_exp - 18.months).pluck(:uid)
      export = EmpireCustomer.where(lic_state: 'PA').where.not(uid: current).all
      @export_count = export.pluck(:uid).uniq
    end

  # ADD Record to Staging
    if params['add'] == 'yes'
      PostcardExport.delete_all
      uid_array = []
      export.each do |empire_customer|
        if uid_array.exclude? empire_customer.uid
          new = PostcardExport.create(
            company: company,
            group: group,
            mail_id: mail_id,
            mail_date: mail_date,
            state: state,
            license_number: empire_customer.license_num,
            uid: empire_customer.uid,
            merge_1: merge_1,
            merge_2: merge_2,
            merge_3: merge_3,
            f_name: empire_customer.fname,
            l_name: empire_customer.lname,
            add_1: empire_customer.street_1,
            add_2: empire_customer.street_2,
            city: empire_customer.city,
            st: empire_customer.state,
            zip: empire_customer.zip,
            email: empire_customer.email)
          new.save
          uid_array.push(empire_customer.uid) #Push new records lic number in to array to not allow duplicates in new table
        end
      end
      redirect_to postcard_exports_path(co: company, group: group, mail_id: mail_id, day: mail_date, card: 'email', sent: @export_count.count)
    end

  end

  def exports
    if params['page'] == 'pa_email'
      @renewal_year = '2020'
      @message = 'PA Return Customer Emails'
      @info = 'Removed users who have purchase in this renewal cycle. Removed Duplicates.'
      @show = EmpireCustomer.where(lic_state: 'PA').first(10)
      @title = 'PA_email'
      export_1 = EmpireCustomer.where(lic_state: 'PA').all
      pa_exclude = export_1.where('p_date > ?', '2018-06-01').pluck(:uid)
      @export_2 = export_1.where.not(uid: pa_exclude).all

      ids = []
      uid = []

      @export_2.each do |i|
        unless uid.include? i.uid
          ids.push(i.id)
          uid.push(i.uid)
        end
      end

      @export = @export_2.where(id: ids).all
    end

    respond_to do |format|
      format.html
      format.csv { send_data @export.to_csv, filename: "#{@title}_#{Date.today}.csv" }
    end

  end

  def sales

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
            street_1: params['street_1'],
            street_2: params['street_2'],
            city: params['city'],
            state: params['state'],
            zip: params['zip'],
            email: params['email'],
            phone: params['phone'])

          new.save

        redirect_to data_mailing_empire_nms_path
      # elsif
        # redirect_to empire_customers_path(done: 'YES')
      # end
    end
    # redirect_to empire_customers_path(done: 'YES')
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
      params.require(:empire_customer).permit(:e_id, :uid, :license_num, :existing, :purchase_date, :lic_state, :products, :order_total, :fname, :lname, :company, :street_1, :street_2, :city, :state, :zip, :email, :phone, :p_date, :total)
    end
end
