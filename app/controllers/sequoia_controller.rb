class SequoiaController < ApplicationController

  def dash_hamdo
    postcard_schedule
    postcard_inventory
    course_update_status
    name
    task
    email_campaign
  end

  def dash_ashley
    postcard_schedule
    postcard_inventory
    course_update_status
    name
    task
    email_campaign
  end

  def dash_michael
    postcard_schedule
    postcard_inventory
    course_update_status
    name
    task
    email_campaign
    msi_mailing
    sequoia_exams
  end

  def dash
    sequoia_exams
    sequoia_exams_old
    sales
    postcard_schedule #must be above postcard_inventory
    postcard_inventory # must be below postcard_schedule
    course_update_status
    tx_royalties
    task
    msi_mailing
    name
  end

  def dash_kyle
    sequoia_exams
    sequoia_exams_old
    sales
    postcard_schedule #must be above postcard_inventory
    postcard_inventory # must be below postcard_schedule
    course_update_status
    tx_royalties
    task
    msi_mailing
    name
  end

private

# def test
#   SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => '2018-09-25').where(:what => 'Ethics')
# end

def sales
    @seq_customers_all = SequoiaCustomer.all
    @date_today = Date.today.beginning_of_month - 365
    # @test = SequoiaCustomer.purchase_date

# Yesterday Sales
      @total_yesterday = SequoiaCustomer.where(:purchase_date => Date.today - 1 ).pluck(:price).sum
      @cpa_yesterday = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today - 1 ).pluck(:price).sum
      @cpa_yesterday_ethics = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today - 1 ).where(:what => 'Ethics').pluck(:price).sum
      @ea_yesterday = SequoiaCustomer.where(:who => 'EA').where(:purchase_date => Date.today - 1 ).pluck(:price).sum
      @afsp_yesterday = SequoiaCustomer.where(:who => 'AFSP').where(:purchase_date => Date.today - 1 ).where(:what => 'AFSP').pluck(:price).sum
      @new_mem = SequoiaCustomer.where(:purchase_date => Date.today - 1 ).where(:what => 'Membership-First').pluck(:price).sum
      @return_mem = SequoiaCustomer.where(:purchase_date => Date.today - 1 ).where(:what => 'Membership-Renewal').pluck(:price).sum
      @column_chart_yesterday = SequoiaCustomer.where(:purchase_date => Date.today - 8..Date.today - 1).group_by_day(:purchase_date, format: '%a, %-d').sum(:price)
# End Yesterday sales

# MTD sales
      @total_mtd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_month..Date.today ).pluck(:price).sum
      @cpa_mtd = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.beginning_of_month..Date.today).pluck(:price).sum
      @cpa_ethics_mtd = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.beginning_of_month..Date.today).where(:what => 'Ethics').pluck(:price).sum
      @ea_mtd = SequoiaCustomer.where(:who => 'EA').where(:purchase_date => Date.today.beginning_of_month..Date.today).pluck(:price).sum
      @afsp_mtd = SequoiaCustomer.where(:who => 'AFSP').where(:purchase_date => Date.today.beginning_of_month..Date.today).where(:what => 'AFSP').pluck(:price).sum
      @new_mem_mtd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_month..Date.today ).where(:what => 'Membership-First').pluck(:price).sum
      @return_mem_mtd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_month..Date.today ).where(:what => 'Membership-Renewal').pluck(:price).sum
      @column_chart_mtd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_month - 365..Date.today).group_by_month(:purchase_date, format: '%b').sum(:price)
# End MTD Sales

# MTD sales
      @sales_last_month_total = SequoiaCustomer.where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month ).pluck(:price).sum
      @sales_last_month_cpa = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month).pluck(:price).sum
      @sales_last_month_cpa_ethics = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month).where(:what => 'Ethics').pluck(:price).sum
      @sales_last_month_ea = SequoiaCustomer.where(:who => 'EA').where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month).pluck(:price).sum
      @sales_last_month_afsp = SequoiaCustomer.where(:who => 'AFSP').where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month).where(:what => 'AFSP').pluck(:price).sum
      @sales_last_month_new_mem = SequoiaCustomer.where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month ).where(:what => 'Membership-First').pluck(:price).sum
      @sales_last_month_return_mem = SequoiaCustomer.where(:purchase_date => Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month ).where(:what => 'Membership-Renewal').pluck(:price).sum
# End MTD Sales

# Start YTD sales
      @total_ytd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_year..Date.today ).pluck(:price).sum
      @cpa_ytd = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.beginning_of_year..Date.today).pluck(:price).sum
      @cpa_ethics_ytd = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.beginning_of_year..Date.today).where(:what => 'Ethics').pluck(:price).sum
      @ea_ytd = SequoiaCustomer.where(:who => 'EA').where(:purchase_date => Date.today.beginning_of_year..Date.today).pluck(:price).sum
      @afsp_ytd = SequoiaCustomer.where(:who => 'AFSP').where(:purchase_date => Date.today.beginning_of_year..Date.today).where(:what => 'AFSP').pluck(:price).sum
      @new_mem_ytd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_year..Date.today ).where(:what => 'Membership-First').pluck(:price).sum
      @return_mem_ytd = SequoiaCustomer.where(:purchase_date => Date.today.beginning_of_year..Date.today ).where(:what => 'Membership-Renewal').pluck(:price).sum
      @column_chart_ytd = SequoiaCustomer.group_by_year(:purchase_date, format: '%Y').sum(:price)
# End YTD Sales

# Start Last Year sales
      @sales_last_year_total = SequoiaCustomer.where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year ).pluck(:price).sum
      @sales_last_year_cpa = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year).pluck(:price).sum
      @sales_last_year_cpa_ethics = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year).where(:what => 'Ethics').pluck(:price).sum
      @sales_last_year_ea = SequoiaCustomer.where(:who => 'EA').where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year).pluck(:price).sum
      @sales_last_year_afsp = SequoiaCustomer.where(:who => 'AFSP').where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year).where(:what => 'AFSP').pluck(:price).sum
      @sales_last_year_new_mem = SequoiaCustomer.where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year ).where(:what => 'Membership-First').pluck(:price).sum
      @sales_last_year_return_mem = SequoiaCustomer.where(:purchase_date => Date.today.last_year.beginning_of_year..Date.today.last_year.end_of_year ).where(:what => 'Membership-Renewal').pluck(:price).sum
# End Last Year Sales
    #   @seq_customers_all.each do |i|
    #     @cpa_purchases = SequoiaCustomer.where(:who => 'CPA').where(:purchase_date => (Date.today - 2))
    #     i['who'] == 'CPA' ? @CPA_all_time = Array.new.push(i['price']) : ''
    #     i['who'] == 'EA' ? @EA_all_time = Array.new.push.push(i['price']) : ''
    #     i['who'] == 'AFSP' ? @AFSP_all_time = Array.new.push.push(i['price']) : ''
    #     @total_all_time = Array.new.push.push(i['price'])
    #   end
    #
    #   @yesterday_all = []
    #   # @yesterday_cpa = []
    #   # @yesterday_ea = []
    #   # @yesterday_afsp = []
    #
    #
    #   @seq_customers_all.each do |i|
    #     i['purchase_date'] > 2.day.ago..Time.now ? i['purchase_date'] < 1.day.ago..Time.now ? (
    #       i['who'] == 'CPA' ? @yesterday_cpa = Array.new.push(i['price']) : ''
    #       i['who'] == 'EA' ? @yesterday_ea = Array.new.push(i['price']) : ''
    #       i['who'] == 'AFSP' ? @yesterday_afsp = Array.new.push(i['price']) : ''
    #       @yesterday_all.push(i['price'])
    #     ) : '' : ''
    #   end
    #
    #   @what_new_cpa = []
    #   @what_new_ea = []
    #   @what_renew_cpa = []
    #   @what_renew_ea = []
    #   @what_ethics = []
    #   @what_afsp = []
    #
    #   @seq_customers_all.each do |i|
    #     i['purchase_date'] > 2.day.ago..Time.now ? i['purchase_date'] < 1.day.ago..Time.now ? (
    #       i['who'] == 'CPA' && i['what'] == 'Membership-First' ? @what_new_cpa.push(i['price']) : ''
    #       i['who'] == 'EA' && i['what'] == 'Membership-First' ? @what_new_ea.push(i['price']) : ''
    #       i['who'] == 'CPA' && i['what'] == 'Membership-Renewal' ? @what_renew_cpa.push(i['price']) : ''
    #       i['who'] == 'EA' && i['what'] == 'Membership-Renewal' ? @what_renew_ea.push(i['price']) : ''
    #       i['who'] == 'CPA' && i['what'] == 'Ethics' ? @what_ethics.push(i['price']) : ''
    #       i['who'] == 'AFSP' ? @what_afsp.push(i['price']) : ''
    #     ) : '' : ''
    #   end
    #
    # @cpa1 = []
    # @ea1 = []
    # @afsp1 = []
    # @mem_first1 = []
    # @mem_renewal1 = []
    # @ethics1 = []
    # @cpa2 = []
    # @ea2 = []
    # @afsp2 = []
    # @cpa3 = []
    # @ea3 = []
    # @afsp3 = []
    # @mem_first2 = []
    # @mem_renewal2 = []
    # @ethics2 = []
    # @mem_first3 = []
    # @mem_renewal3 = []
    # @ethics3 = []
    # @mtd_total =[]
    # @last_month_total = []
    #
    # @t = SequoiaCustomer.group_by_year(:purchase_date, current: false, format: '%Y').sum(:price)
    # # @t6 = SequoiaCustomer.group_by_year(:purchase_date, format: '%Y').group(:who).sum(:price)
    # @t6 = SequoiaCustomer.group(:what).sum(:price)
    # @t7 = SequoiaCustomer.sum(:price)
    #
    # @t1 = SequoiaCustomer.group_by_day(:purchase_date, last: 3, format: ('%a')).group(:who).sum(:price)
    # @t2 = SequoiaCustomer.group_by_day(:purchase_date, last: 3, format: ('%a')).group(:what).sum(:price)
    #
    # @t3 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).group(:who).sum(:price)
    # @t4 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).sum(:price)
    # @t5 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).group(:what).sum(:price)
    #
    # @t1.each do |key, value|
    #     key[1] == "CPA" && key[0] == 1.day.ago.strftime('%a') ? @cpa1.push(value) : ''
    #     key[1] == "EA" && key[0] == 1.day.ago.strftime('%a') ? @ea1.push(value) : ''
    #     key[1] == "AFSP" && key[0] == 1.day.ago.strftime('%a') ? @afsp1.push(value) : ''
    # end
    #
    # @t2.each do |key, value|
    #     key[1] == "Membership-First" && key[0] == 1.day.ago.strftime('%a') ? @mem_first1.push(value) : ''
    #     key[1] == "Membership-Renewal" && key[0] == 1.day.ago.strftime('%a') ? @mem_renewal1.push(value) : ''
    #     key[1] == "Ethics" && key[0] == 1.day.ago.strftime('%a') ? @ethics1.push(value) : ''
    # end
    #
    # @t3.each do |key, value|
    #     key[0] == 0.month.ago.strftime('%B') ? @mtd_total.push(value) : ''
    #     key[0] == 1.month.ago.strftime('%B') ? @last_month_total.push(value) : ''
    #     key[1] == "CPA" && key[0] == 0.month.ago.strftime('%B') ? @cpa2.push(value) : ''
    #     key[1] == "EA" && key[0] == 0.month.ago.strftime('%B') ? @ea2.push(value) : ''
    #     key[1] == "AFSP" && key[0] == 0.month.ago.strftime('%B') ? @afsp2.push(value) : ''
    #     key[1] == "CPA" && key[0] == 1.month.ago.strftime('%B') ? @cpa3.push(value) : ''
    #     key[1] == "EA" && key[0] == 1.month.ago.strftime('%B') ? @ea3.push(value) : ''
    #     key[1] == "AFSP" && key[0] == 1.month.ago.strftime('%B') ? @afsp3.push(value) : ''
    # end
    #
    # @t5.each do |key, value|
    #     key[1] == "Membership-First" && key[0] == 0.month.ago.strftime('%B') ? @mem_first2.push(value) : ''
    #     key[1] == "Membership-Renewal" && key[0] == 0.month.ago.strftime('%B') ? @mem_renewal2.push(value) : ''
    #     key[1] == "Ethics" && key[0] == 0.month.ago.strftime('%B') ? @ethics2.push(value) : ''
    #     key[1] == "Membership-First" && key[0] == 1.month.ago.strftime('%B') ? @mem_first3.push(value) : ''
    #     key[1] == "Membership-Renewal" && key[0] == 1.month.ago.strftime('%B') ? @mem_renewal3.push(value) : ''
    #     key[1] == "Ethics" && key[0] == 1.month.ago.strftime('%B') ? @ethics3.push(value) : ''
    # end
  end

  def task
    @tasks = Task.all


  end

  def msi_mailing
    @mailings = Mailing.all.order(:drop).reverse_order

    @ytd_drops = []
    @ytd_quanity = []
    @ytd_cost = []

    @last_year_drops = []
    @last_year_quanity = []
    @last_year_cost = []

    @all_time_drops = []
    @all_time_quanity = []
    @all_time_cost = []

    @next_msi_mailing = []

    @next_msi_mailing_date_cpa = Mailing.where('drop > ?', Date.today - 10).where(:who => 'CPA').pluck(:drop).min
    @last_msi_mailing_date_cpa = Mailing.where('drop < ?', Date.today - 10).where(:complete => true).where(:who => 'CPA').pluck(:drop).max
    @next_msi_mailing_date_ea = Mailing.where('drop > ?', Date.today - 10).where(:who => 'EA').pluck(:drop).min
    @last_msi_mailing_date_ea = Mailing.where('drop < ?', Date.today - 10).where(:complete => true).where(:who => 'EA').pluck(:drop).max

    @most_recent_msi_drop = []

    @art_missing = []

    @mailings.each do |mailing|
      if mailing.boolean_1 == false
        @next_msi_mailing.push(mailing['drop'])
      end
      if mailing.complete == true && mailing.drop < Date.today
        @most_recent_msi_drop.push(mailing['drop'])
      end
      if mailing.drop.strftime('%Y') == Date.today.year.to_s
        if mailing.cost_print.nil? || mailing.cost_postage.nil? || mailing.cost_service.nil?
        elsif
           @ytd_cost.push(mailing['cost_print'])
           @ytd_cost.push(mailing['cost_postage'])
           @ytd_cost.push(mailing['cost_service'])
         end
         if mailing.complete == true
           @ytd_drops.push(mailing['name'])
         end
         if mailing.quantity_sent.nil?
         elsif
           @ytd_quanity.push(mailing['quantity_sent'])
        end
      end
      if mailing.drop.strftime('%Y') == (Date.today.year - 1).to_s
        if mailing.cost_print.nil? || mailing.cost_postage.nil? || mailing.cost_service.nil?
        elsif
          @last_year_cost.push(mailing['cost_print'])
          @last_year_cost.push(mailing['cost_postage'])
          @last_year_cost.push(mailing['cost_service'])
        end
        @last_year_drops = Array.new.push(mailing['name'])
        if mailing.quantity_sent.nil?
        elsif
          @last_year_quanity = Array.new.push(mailing['quantity_sent'])
        end
      end
        if mailing.cost_print.nil? || mailing.cost_postage.nil? || mailing.cost_service.nil?
        elsif
          @all_time_cost.push(mailing['cost_print'])
          @all_time_cost.push(mailing['cost_postage'])
          @all_time_cost.push(mailing['cost_service'])
        end
        @all_time_drops.push(mailing['name'])
          if mailing.quantity_sent.nil?
          elsif
            @all_time_quanity.push(mailing['quantity_sent'])
          end

        if mailing.complete == false && mailing.msi_art.url =~/missing/
          @art_missing.push(mailing['drop'])
        end
    end
end

def course_update_status
    @updatesheets = Updatesheet.all
    @course_update_status = []
    @course_update_status_proofing = []

    @updatesheets.each do |updatesheet|
      if updatesheet.course_listed == true && updatesheet.text_complete == true && updatesheet.exam_complete == true || updatesheet.extra_boolean == true
        @course_update_status.push(0)
      elsif
        @course_update_status.push(1)
      end
      if updatesheet.course_listed == true && updatesheet.text_complete == true && updatesheet.exam_complete == true && updatesheet.proofed == false
        @course_update_status_proofing.push(1)
      elsif
        @course_update_status_proofing.push(0)
      end
    end
end

def tx_royalties
    @tx_royalties = TxRoyalty.all
    @next_due = []

    @tx_royalties.each do |tx_royalty|
      if tx_royalty.sent == false
        @next_due.push(tx_royalty['end_date'])
      end
    end
end

def postcard_schedule
    @day_of_week = Date.today.strftime('%a')
    @postcard_mailings = PostcardMailing.all
  #Postcard Due Dates
      @day_of_week == 'Sat' || @day_of_week == 'Sun' || @day_of_week == 'Mon' ? @due_sequoia_1 = "Tuesday" :
      @day_of_week == 'Tue' || @day_of_week == 'Fri' ? @due_sequoia_1 = "Due Today" :
      @day_of_week == 'Wed' || @day_of_week == 'Thu' ? @due_sequoia_1 = "Due Friday" : ''

      @day_of_week == 'Mon' || @day_of_week == 'Tue' || @day_of_week == 'Thu' || @day_of_week == 'Fri' ? @due_empire_1 = "Due Wed" :
      @day_of_week == 'Wed' ? @due_empire_1 = "Due Today" : ''
  #Postcard Due Dates

  #Postcard overdue

    @seq_cpa_nm = []
    @seq_cpa_rc = []
    @seq_ea_nm = []
    @seq_ea_rc = []
    @most_recent_postcart_mailing_empire = []

      @postcard_mailings.each do |postcard_mailings|
        postcard_mailings['company'] == 'Sequoia' && postcard_mailings['version'] == 'CPA NM' ? @seq_cpa_nm.push(postcard_mailings['date_sent']) : ''
        postcard_mailings['company'] == 'Sequoia' && postcard_mailings['version'] == 'CPA RC' ? @seq_cpa_rc.push(postcard_mailings['date_sent']) : ''
        postcard_mailings['company'] == 'Sequoia' && postcard_mailings['version'] == 'EA NM' ? @seq_ea_nm.push(postcard_mailings['date_sent']) : ''
        postcard_mailings['company'] == 'Sequoia' && postcard_mailings['version'] == 'EA RC' ? @seq_ea_rc.push(postcard_mailings['date_sent']) : ''
        postcard_mailings['company'] == 'Empire' && postcard_mailings['version'] == 'Empire RC' ? @most_recent_postcart_mailing_empire.push(postcard_mailings['date_sent']) : ''
      end

      @most_recent_postcart_mailing_sequoia = [@seq_cpa_nm.max, @seq_cpa_rc.max, @seq_ea_nm.max, @seq_ea_rc.max]

  # Sequoia
      @day_of_week == 'Wed' && @most_recent_postcart_mailing_sequoia.min < Date.today - 1 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Thu' && @most_recent_postcart_mailing_sequoia.min < Date.today - 2 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Fri' && @most_recent_postcart_mailing_sequoia.min < Date.today - 3 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Mon' && @most_recent_postcart_mailing_sequoia.min < Date.today - 3 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Tue' && @most_recent_postcart_mailing_sequoia.min < Date.today - 4 ? @out_of_date_sequoia = 'True' : @out_of_date_sequoia = 'False'

  # Empire
      @day_of_week == 'Thu' && @most_recent_postcart_mailing_empire.max < Date.today - 1 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Fri' && @most_recent_postcart_mailing_empire.max < Date.today - 2 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Mon' && @most_recent_postcart_mailing_empire.max < Date.today - 5 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Tue' && @most_recent_postcart_mailing_empire.max < Date.today - 6 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Wed' && @most_recent_postcart_mailing_empire.max < Date.today - 7 ? @out_of_date_empire = 'True' : @out_of_date_empire = 'False'

  end

  def postcard_inventory
  @inventories = Inventory.all

  @postcard_inventory = Inventory.group(:company).group(:version).group(:order).sum(:number)

  @date_sequoia_cpa_nm = []
  @date_sequoia_cpa_rc = []
  @date_sequoia_ea_nm = []
  @date_sequoia_ea_rc = []
  @date_empire_rc = []

    @inventories.each do |inventory|
       inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA NM' ? @date_sequoia_cpa_nm.push(inventory['order']) : ''
       inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA RC' ? @date_sequoia_cpa_rc.push(inventory['order']) : ''
       inventory['company'] == 'Sequoia' && inventory['version'] == 'EA NM' ? @date_sequoia_ea_nm.push(inventory['order']) : ''
       inventory['company'] == 'Sequoia' && inventory['version'] == 'EA RC' ? @date_sequoia_ea_rc.push(inventory['order']) : ''
       inventory['company'] == 'Empire' && inventory['version'] == 'Empire RC' ? @date_empire_rc.push(inventory['order']) : ''
    end

  @used_sequoia_cpa_nm = []
  @used_sequoia_cpa_rc = []
  @used_sequoia_ea_nm = []
  @used_sequoia_ea_rc = []
  @used_empire_rc = []

    @postcard_mailings.each do |sent|
       sent['company'] == 'Sequoia' && sent['version'] == 'CPA NM' ? @used_sequoia_cpa_nm.push(sent['number_sent']) : ''
       sent['company'] == 'Sequoia' && sent['version'] == 'CPA RC' ? @used_sequoia_cpa_rc.push(sent['number_sent']) : ''
       sent['company'] == 'Sequoia' && sent['version'] == 'EA NM' ? @used_sequoia_ea_nm.push(sent['number_sent']) : ''
       sent['company'] == 'Sequoia' && sent['version'] == 'EA RC' ? @used_sequoia_ea_rc.push(sent['number_sent']) : ''
       sent['company'] == 'Empire' && sent['version'] == 'Empire RC' ? @used_empire_rc.push(sent['number_sent']) : ''
    end

  @inventory_sequoia_cpa_nm = []
  @inventory_sequoia_cpa_rc = []
  @inventory_sequoia_ea_nm = []
  @inventory_sequoia_ea_rc = []
  @inventory_empire_rc = []

    @inventories.each do |inventory|
      inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA NM' ? @inventory_sequoia_cpa_nm.push(inventory['number']) : ''
      inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA RC' ? @inventory_sequoia_cpa_rc.push(inventory['number']) : ''
      inventory['company'] == 'Sequoia' && inventory['version'] == 'EA NM' ? @inventory_sequoia_ea_nm.push(inventory['number']) : ''
      inventory['company'] == 'Sequoia' && inventory['version'] == 'EA RC' ? @inventory_sequoia_ea_rc.push(inventory['number']) : ''
      inventory['company'] == 'Empire' && inventory['version'] == 'Empire RC' ? @inventory_empire_rc.push(inventory['number']) : ''
    end

  @number_sequoia_cpa_nm = []
  @number_sequoia_cpa_rc = []
  @number_sequoia_ea_nm = []
  @number_sequoia_ea_rc = []
  @number_empire_rc = []

    @inventories.each do |inventory|
      inventory['company'] == "Sequoia" && inventory['version'] == "CPA NM" && inventory['order'] == @date_sequoia_cpa_nm.max ? @number_sequoia_cpa_nm.push(inventory['number']) : ''
      inventory['company'] == "Sequoia" && inventory['version'] == "CPA RC" && inventory['order'] == @date_sequoia_cpa_rc.max ? @number_sequoia_cpa_rc.push(inventory['number']) : ''
      inventory['company'] == "Sequoia" && inventory['version'] == "EA NM" && inventory['order'] == @date_sequoia_ea_nm.max ? @number_sequoia_ea_nm.push(inventory['number']) : ''
      inventory['company'] == "Sequoia" && inventory['version'] == "EA RC" && inventory['order'] == @date_sequoia_ea_rc.max ? @number_sequoia_ea_rc.push(inventory['number']) : ''
      inventory['company'] == "Empire" && inventory['version'] == "Empire RC" && inventory['order'] == @date_empire_rc.max ? @number_empire_rc.push(inventory['number']) : ''
    end

    @remaining_inventory_sequoia_cpa_nm = (@inventory_sequoia_cpa_nm.sum - @used_sequoia_cpa_nm.sum)
    @remaining_inventory_sequoia_cpa_rc = (@inventory_sequoia_cpa_rc.sum - @used_sequoia_cpa_rc.sum)
    @remaining_inventory_sequoia_ea_nm = (@inventory_sequoia_ea_nm.sum - @used_sequoia_ea_nm.sum)
    @remaining_inventory_sequoia_ea_rc = (@inventory_sequoia_ea_rc.sum - @used_sequoia_ea_rc.sum)
    @remaining_inventory_empire_rc = (@inventory_empire_rc.sum - @used_empire_rc.sum)

    @remaining_inventory = Array.new.push(@remaining_inventory_sequoia_cpa_nm, @remaining_inventory_sequoia_cpa_rc, @remaining_inventory_sequoia_ea_nm, @remaining_inventory_sequoia_ea_rc, @remaining_inventory_empire_rc)

  end

  def name
    user_signed_in? && current_user.email == 'austin@sequoiacpe.com' ? @name = 'Austin' : ''
    user_signed_in? && current_user.email == 'michael@sequoiacpe.com' ? @name = 'Michael' : ''
    user_signed_in? && current_user.email == 'kyle@sequoiacpe.com' ? @name = 'Kyle' : ''
    user_signed_in? && current_user.email == 'ashley@sequoiacpe.com' ? @name = 'Ashley' : ''

    @user_task = 'task.user_1'
  end

  def email_campaign
    @email_campaigns = EmailCampaign.all

@last_updated_stats = []
    @email_campaigns.each do |email_campaign|
      if email_campaign.company == 'Empire' && email_campaign.active == true
        @last_updated_stats.push(email_campaign['update_stats'])
      end
      end

  end

  def sequoia_exams_old

    @start_of_month = Date.today.beginning_of_month

    @end_of_month = Date.today.end_of_month
    @sequoia_exams_all = ExamResult.order(:course_number).all

    @exams_total = @sequoia_exams_all.pluck(:taken).sum

    @bar_chart_cpa_month = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'CPA').where(:week_s => @start_of_month).where('course_number < ?', 9000).where('course_number >= ?', 1000).group(:course_number).sum(:taken)
    @bar_chart_ea_month = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'EA').where(:week_s => @start_of_month).where('course_number < ?', 4000).where('course_number >= ?', 3000).group(:course_number).sum(:taken)

    @month_courses_cpa = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'CPA').where(:week_s => @start_of_month).pluck(:course_number).count
    @month_courses_ea = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'EA').where(:week_s => @start_of_month).pluck(:course_number).count
    @month_exams_cpa = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'CPA').where(:week_s => @start_of_month).pluck(:taken).sum
    @month_exams_ea = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'EA').where(:week_s => @start_of_month).pluck(:taken).sum

      @month_score_cpa = []
      @month_score_ea = []
      @month_score_all = []
      @month_rating_cpa = []
      @month_courses_rated_cpa = []
      @month_rating_ea = []
      @month_courses_rated_ea = []
      @month_rating_all = []
      @month_courses_rated_all = []

      @sequoia_exams_all.each do |i|
        # Start Month
        i['extra_s'] == 'Month' && i['who'] == 'CPA' && i['week_s'] == (@start_of_month) ? @month_score_cpa.push(i['score_avg'] * i['taken']) : ''
        i['extra_s'] == 'Month' && i['who'] == 'EA' && i['week_s'] == (@start_of_month) ? @month_score_ea.push(i['score_avg'] * i['taken']) : ''
        i['extra_s'] == 'Month' && i['week_s'] == (@start_of_month) ? @month_score_all.push(i['score_avg'] * i['taken']) : ''
        if i['rating'].nil?
        elsif
          i['extra_s'] == 'Month' && i['who'] == 'CPA' && i['week_s'] == (@start_of_month) ? @month_rating_cpa.push(i['rating'] * i['taken']) : ''
          i['extra_s'] == 'Month' && i['who'] == 'CPA' && i['week_s'] == (@start_of_month) ? @month_courses_rated_cpa.push(i['taken']) : ''
          i['extra_s'] == 'Month' && i['who'] == 'EA' && i['week_s'] == (@start_of_month) ? @month_rating_ea.push(i['rating'] * i['taken']) : ''
          i['extra_s'] == 'Month' && i['who'] == 'EA' && i['week_s'] == (@start_of_month) ? @month_courses_rated_ea.push(i['taken']) : ''
          i['extra_s'] == 'Month' && i['week_s'] == (@start_of_month) ? @month_rating_all.push(i['rating'] * i['taken']) : ''
          i['extra_s'] == 'Month' && i['week_s'] == (@start_of_month) ? @month_courses_rated_all.push(i['taken']) : ''
        end
        # End month
      end
  end

  def sequoia_exams
    @sequoia_exams = SequoiaExam.order(:course_number).all

    @sequoia_exams_grouped_taken_cpa = SequoiaExam.order(:course_number).group(:course_number).where(:who => 'CPA').where('course_number < ?', 9000).where('course_number >= ?', 1000).count(:course_number)
    @sequoia_exams_grouped_score_sum_cpa = SequoiaExam.order(:course_number).group(:course_number).where(:who => 'CPA').where('course_number < ?', 9000).where('course_number >= ?', 1000).sum(:score)
    @sequoia_exams_grouped_rating_sum_cpa = SequoiaExam.order(:course_number).group(:course_number).where('rate > ?', 0).where(:who => 'CPA').where('course_number < ?', 9000).where('course_number >= ?', 1000).sum(:rate)
    @sequoia_exams_grouped_rating_total_cpa = SequoiaExam.order(:course_number).group(:course_number).where('rate > ?', 0).where(:who => 'CPA').where('course_number < ?', 9000).where('course_number >= ?', 1000).count(:rate)

    @sequoia_exams_grouped_taken_ea = SequoiaExam.order(:course_number).group(:course_number).where(:who => 'EA').where('course_number >= ?', 3000).count(:course_number)
    @sequoia_exams_grouped_score_sum_ea = SequoiaExam.order(:course_number).group(:course_number).where(:who => 'EA').where('course_number >= ?', 3000).sum(:score)
    @sequoia_exams_grouped_rating_sum_ea = SequoiaExam.order(:course_number).group(:course_number).where('rate > ?', 0).where(:who => 'EA').where('course_number >= ?', 3000).sum(:rate)
    @sequoia_exams_grouped_rating_total_ea = SequoiaExam.order(:course_number).group(:course_number).where('rate > ?', 0).where(:who => 'EA').where('course_number >= ?', 3000).count(:rate)

    # @exam_chart_cpa = SequoiaExam.order(:course_number).group(:course_number).where().count(:course_number)

    @hash_1_merge_cpa = @sequoia_exams_grouped_taken_cpa.merge(@sequoia_exams_grouped_score_sum_cpa) {|k,v1,v2|[v1,v2]}
    @hash_2_merge_cpa = @sequoia_exams_grouped_rating_total_cpa.merge(@sequoia_exams_grouped_rating_sum_cpa){|k,v1,v2|[v1,v2]}
    @sequoia_exams_hash_cpa = @hash_1_merge_cpa.merge(@hash_2_merge_cpa){|k,v1,v2|[v1,v2]}

    @hash_1_merge_ea = @sequoia_exams_grouped_taken_ea.merge(@sequoia_exams_grouped_score_sum_ea) {|k,v1,v2|[v1,v2]}
    @hash_2_merge_ea = @sequoia_exams_grouped_rating_total_ea.merge(@sequoia_exams_grouped_rating_sum_ea){|k,v1,v2|[v1,v2]}
    @sequoia_exams_hash_ea = @hash_1_merge_ea.merge(@hash_2_merge_ea){|k,v1,v2|[v1,v2]}

    # @sequoia_exams_hash_all = @sequoia_exams_hash_ea.merge(@sequoia_exams_hash_cpa){|k,v1,v2|[v1,v2]}

    # Totals
    @total_taken = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).count(:course_number)
    @total_sum_score = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).sum(:score)
    @total_taken_rating = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).where('rate > ?', 0).count(:rate)
    @total_sum_rating = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).where('rate > ?', 0).sum(:rate)

    @total_taken_cpa = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).where(:who => 'CPA').count(:course_number)
    @total_sum_score_cpa = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).where(:who => 'CPA').sum(:score)
    @total_taken_rating_cpa = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).where(:who => 'CPA').where('rate > ?', 0).count(:rate)
    @total_sum_rating_cpa = SequoiaExam.where('course_number >= ?', 1000).where('course_number < ?', 10000).where(:who => 'CPA').where('rate > ?', 0).sum(:rate)

    @total_taken_ea = SequoiaExam.where('course_number >= ?', 3000).where('course_number < ?', 10000).where(:who => 'EA').count(:course_number)
    @total_sum_score_ea = SequoiaExam.where('course_number >= ?', 3000).where('course_number < ?', 10000).where(:who => 'EA').sum(:score)
    @total_taken_rating_ea = SequoiaExam.where('course_number >= ?', 3000).where('course_number < ?', 10000).where(:who => 'EA').where('rate > ?', 0).count(:rate)
    @total_sum_rating_ea = SequoiaExam.where('course_number >= ?', 3000).where('course_number < ?', 10000).where(:who => 'EA').where('rate > ?', 0).sum(:rate)

  end

end
