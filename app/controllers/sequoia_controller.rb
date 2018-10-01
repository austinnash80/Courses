class SequoiaController < ApplicationController

  def dash_ashley
    postcard_schedule
    postcard_inventory
    course_update_status
  end

  def dash
    postcard_schedule #must be above postcard_inventory
    postcard_inventory # must be below postcard_schedule
    course_update_status
    tx_royalties



    @seq_customers_all = SequoiaCustomer.all
    # @pur_date = @seq_customers_all.purchase.strftime('%a, %-d')
        # collumn sales chart - Start

        # @seq_customers_all.each do |i|
        #   i['purchase'] > 1.day.ago..Time.now.yesterday ? (

          @cpa_1 = []
          @ea_1 = []
          @ethics_1 = []
          @afsp_1 = []

          # @seq_customers_all.each do |i|
          #   i['purchase_date'] > 1.week.ago..Time.now.yesterday ? (
          #     i['product_1'] == "1-Year CPA Membership Discounted Re-Activation" || i['product_1'] == "1-Year CPA Membership Re-Activation" ||
          #     i['product_1'] == "1-Year CPA Membership Renewal" || i['product_1'] == "1-Year CPA Membership Renewal (Auto-Renew)" ||
          #     i['product_1'] == "Unlimited CPA CPE Membership" || i['product_1'] == "Unlimited CPA CPE Membership (Auto-Renew)" ? @cpa_1.push("CPA") : ''
          #     i['product_1'] == "1-Year EA Membership Discounted Re-Activation" || i['product_1'] == "1-Year EA Membership Re-Activation" ||
          #     i['product_1'] == "1-Year EA Membership Renewal" || i['product_1'] == "1-Year EA Membership Renewal (Auto-Renew)" ||
          #     i['product_1'] == "Unlimited EA CPE Membership" || i['product_1'] == "Unlimited EA Membership (Auto-Renew)" ? @ea_1.push("EA") : ''
          #     i['product_1'] == "15-hour AFTR-Exempt Package" || i['product_1'] == "18-hour AFTR Package" ||
          #     i['product_1'] == "CE 100 - 11hr. AFTR Package" || i['product_1'] == "CE 200 - 8hr. AFTR-Exempt Package" ? @afsp_1.push("AFSP") : ''
          #     i['product_1'][0] == "9" || i['product_1'][0] == "E" ? @ethics_1.push("Ethics") : ''
          # ) : ''
          # end
          # @cpa_1a = []
          # @ea_1a = []
          # @ethics_1a = []
          # @afsp_1a = []
          #
          #   @cpa_1a.push(@cpa_1.first, (@cpa_1.length * 149))
          #   @ea_1a.push(@ea_1.first, @ea_1.length * 99)
          #   @ethics_1a.push(@ethics_1.first, @ethics_1.length * 65.5)
          #   @afsp_1a.push(@afsp_1.first, @afsp_1.length * 55)
          #
          #   @pie_1 = []
          #   @pie_1.push(@cpa_1a, @ea_1a, @ethics_1a, @afsp_1a)
      # collumn sales chart - Start

      @CPA_all_time = []
      @EA_all_time = []
      @AFSP_all_time = []
      @total_all_time = []
      @seq_customers_all.each do |i|
        i['who'] == 'CPA' ? @CPA_all_time.push(i['price']) : ''
        i['who'] == 'EA' ? @EA_all_time.push(i['price']) : ''
        i['who'] == 'AFSP' ? @AFSP_all_time.push(i['price']) : ''
        @total_all_time.push(i['price'])
      end

      @yesterday_all = []
      @yesterday_cpa = []
      @yesterday_ea = []
      @yesterday_afsp = []


      @seq_customers_all.each do |i|
        # i['purchase_date'].group_by_day() ? (
        i['purchase_date'] > 2.day.ago..Time.now ? i['purchase_date'] < 1.day.ago..Time.now ? (
        # i['purchase_date'] >= 2.day.ago..Time.now.yesterday ? i['purchase_date'] < Time.now.yesterday ? (
          i['who'] == 'CPA' ? @yesterday_cpa.push(i['price']) : ''
          i['who'] == 'EA' ? @yesterday_ea.push(i['price']) : ''
          i['who'] == 'AFSP' ? @yesterday_afsp.push(i['price']) : ''
          @yesterday_all.push(i['price'])
        ) : '' : ''
      end

      # Last Monthly

      @month_all = []
      # @seq_customers_all.each do |i|
      #   i['purchase_date'] > 2.month.ago..Time.now ? i['purchase_date'] < 1.month.ago..Time.now ? (
      #     @month_all.push(i['price'])
      #   ) : '' : ''
      # end

      @what_new_cpa = []
      @what_new_ea = []
      @what_renew_cpa = []
      @what_renew_ea = []
      @what_ethics = []
      @what_afsp = []

      @seq_customers_all.each do |i|
        i['purchase_date'] > 2.day.ago..Time.now ? i['purchase_date'] < 1.day.ago..Time.now ? (
          i['who'] == 'CPA' && i['what'] == 'Membership-First' ? @what_new_cpa.push(i['price']) : ''
          i['who'] == 'EA' && i['what'] == 'Membership-First' ? @what_new_ea.push(i['price']) : ''
          i['who'] == 'CPA' && i['what'] == 'Membership-Renewal' ? @what_renew_cpa.push(i['price']) : ''
          i['who'] == 'EA' && i['what'] == 'Membership-Renewal' ? @what_renew_ea.push(i['price']) : ''
          i['who'] == 'CPA' && i['what'] == 'Ethics' ? @what_ethics.push(i['price']) : ''
          i['who'] == 'AFSP' ? @what_afsp.push(i['price']) : ''
        ) : '' : ''
      end

    @cpa1 = []
    @ea1 = []
    @afsp1 = []
    @mem_first1 = []
    @mem_renewal1 = []
    @ethics1 = []
    @cpa2 = []
    @ea2 = []
    @afsp2 = []
    @cpa3 = []
    @ea3 = []
    @afsp3 = []
    @mem_first2 = []
    @mem_renewal2 = []
    @ethics2 = []
    @mem_first3 = []
    @mem_renewal3 = []
    @ethics3 = []
    @mtd_total =[]
    @last_month_total = []

    @t = SequoiaCustomer.group_by_year(:purchase_date, current: false, format: '%Y').sum(:price)
    # @t6 = SequoiaCustomer.group_by_year(:purchase_date, format: '%Y').group(:who).sum(:price)
    @t6 = SequoiaCustomer.group(:what).sum(:price)
    @t7 = SequoiaCustomer.sum(:price)

    @t1 = SequoiaCustomer.group_by_day(:purchase_date, last: 3, format: ('%a')).group(:who).sum(:price)
    @t2 = SequoiaCustomer.group_by_day(:purchase_date, last: 3, format: ('%a')).group(:what).sum(:price)

    @t3 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).group(:who).sum(:price)
    @t4 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).sum(:price)
    @t5 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).group(:what).sum(:price)

    @t1.each do |key, value|
        key[1] == "CPA" && key[0] == 1.day.ago.strftime('%a') ? @cpa1.push(value) : ''
        key[1] == "EA" && key[0] == 1.day.ago.strftime('%a') ? @ea1.push(value) : ''
        key[1] == "AFSP" && key[0] == 1.day.ago.strftime('%a') ? @afsp1.push(value) : ''
    end

    @t2.each do |key, value|
        key[1] == "Membership-First" && key[0] == 1.day.ago.strftime('%a') ? @mem_first1.push(value) : ''
        key[1] == "Membership-Renewal" && key[0] == 1.day.ago.strftime('%a') ? @mem_renewal1.push(value) : ''
        key[1] == "Ethics" && key[0] == 1.day.ago.strftime('%a') ? @ethics1.push(value) : ''
    end

    @t3.each do |key, value|
        key[0] == 0.month.ago.strftime('%B') ? @mtd_total.push(value) : ''
        key[0] == 1.month.ago.strftime('%B') ? @last_month_total.push(value) : ''
        key[1] == "CPA" && key[0] == 0.month.ago.strftime('%B') ? @cpa2.push(value) : ''
        key[1] == "EA" && key[0] == 0.month.ago.strftime('%B') ? @ea2.push(value) : ''
        key[1] == "AFSP" && key[0] == 0.month.ago.strftime('%B') ? @afsp2.push(value) : ''
        key[1] == "CPA" && key[0] == 1.month.ago.strftime('%B') ? @cpa3.push(value) : ''
        key[1] == "EA" && key[0] == 1.month.ago.strftime('%B') ? @ea3.push(value) : ''
        key[1] == "AFSP" && key[0] == 1.month.ago.strftime('%B') ? @afsp3.push(value) : ''
    end

    @t5.each do |key, value|
        key[1] == "Membership-First" && key[0] == 0.month.ago.strftime('%B') ? @mem_first2.push(value) : ''
        key[1] == "Membership-Renewal" && key[0] == 0.month.ago.strftime('%B') ? @mem_renewal2.push(value) : ''
        key[1] == "Ethics" && key[0] == 0.month.ago.strftime('%B') ? @ethics2.push(value) : ''
        key[1] == "Membership-First" && key[0] == 1.month.ago.strftime('%B') ? @mem_first3.push(value) : ''
        key[1] == "Membership-Renewal" && key[0] == 1.month.ago.strftime('%B') ? @mem_renewal3.push(value) : ''
        key[1] == "Ethics" && key[0] == 1.month.ago.strftime('%B') ? @ethics3.push(value) : ''
    end


    #     if key[1] == "CPA"
    #       @cpa1.push(value)
    #       number_to_currency(@cpa1.first, :precision => 0)
    #     end
    #     if key[1] == "EA"
    #       @ea1.push(value)
    #     end
    #     <% if key[1] == "AFSP" %>
    #       <% @afsp1.push(value) %>
    #       <td> <%= number_to_currency(@afsp1.first, :precision => 0) %> </td>
    #     <% end %>
    #   <% end %>
    # <% end %>

    # @d = 2.day.ago..Time.now
    # # @d = 1.day.ago.strftime('%Y-%m-%d')
    # @d1 = 1.day.ago..Time.now

    # --- Task Section ----
    @tasks = Task.all

    # --- Mailing Section ----
    @mailings = Mailing.all.order(:drop).reverse_order

    # @total_cost = (@mailing.cost_postage + @mailing.cost_print + @mailing.cost_service)
    # @unit_total_cost = @total_cost / @mailing.quantity_sent
    # @unit_service_cost = @mailing.cost_service / @mailing.quantity_sent
    # @unit_print_cost = @mailing.cost_print / @mailing.quantity_sent
    # @unit_postage_cost = @mailing.cost_postage / @mailing.quantity_sent

    @ytd_drops = []
    @ytd_quanity = []
    @ytd_cost = []

    @last_year_drops = []
    @last_year_quanity = []
    @last_year_cost = []

    @all_time_drops = []
    @all_time_quanity = []
    @all_time_cost = []

    @mailings.each do |mailing|
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
        @last_year_drops.push(mailing['name'])
          if mailing.quantity_sent.nil?
          elsif
            @last_year_quanity.push(mailing['quantity_sent'])
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
    end
end#End of Dash

def course_update_status
    @updatesheets = Updatesheet.all
    @course_update_status = []

    @updatesheets.each do |updatesheet|
      if updatesheet.course_listed == true && updatesheet.text_complete == true && updatesheet.exam_complete == true && updatesheet.proofed == true
        @course_update_status.push(0)
      elsif
        @course_update_status.push(1)
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

private
  def postcard_schedule
    @day_of_week = Time.now.strftime('%a')
    @postcard_mailings = PostcardMailing.all
  #Postcard Due Dates
      @day_of_week == 'Sat' || @day_of_week == 'Sun' || @day_of_week == 'Mon' ? @due_sequoia_1 = "Tuesday" :
      @day_of_week == 'Tue' || @day_of_week == 'Fri' ? @due_sequoia_1 = "Due Today" :
      @day_of_week == 'Wen' || @day_of_week == 'Thu' ? @due_sequoia_1 = "Friday" : ''

      @day_of_week == 'Mon' || @day_of_week == 'Tue' || @day_of_week == 'Thu' || @day_of_week == 'Fri' ? @due_empire_1 = "Due Wen" :
      @day_of_week == 'Wen' ? @due_empire_1 = "Due Today" : ''
  #Postcard Due Dates

  #Postcard overdue
    @most_recent_postcart_mailing_sequoia = []
    @most_recent_postcart_mailing_empire = []


      @postcard_mailings.each do |postcard_mailings|
        if postcard_mailings['company'] == 'Sequoia'
          @most_recent_postcart_mailing_sequoia.push(postcard_mailings['date_sent'])
        end
        if postcard_mailings['company'] == 'Empire'
          @most_recent_postcart_mailing_empire.push(postcard_mailings['date_sent'])
        end
      end
  # Sequoia
      @day_of_week == 'Wen' && @most_recent_postcart_mailing_sequoia.max <= Date.today - 1 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Thu' && @most_recent_postcart_mailing_sequoia.max <= Date.today - 2 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Fri' && @most_recent_postcart_mailing_sequoia.max <= Date.today - 3 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Mon' && @most_recent_postcart_mailing_sequoia.max <= Date.today - 3 ? @out_of_date_sequoia = 'True' :
      @day_of_week == 'Tue' && @most_recent_postcart_mailing_sequoia.max <= Date.today - 4 ? @out_of_date_sequoia = 'True' : @out_of_date_sequoia = 'False'

  # Empire
      @day_of_week == 'Thu' && @most_recent_postcart_mailing_empire.max <= Date.today - 1 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Fri' && @most_recent_postcart_mailing_empire.max <= Date.today - 2 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Mon' && @most_recent_postcart_mailing_empire.max <= Date.today - 5 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Tue' && @most_recent_postcart_mailing_empire.max <= Date.today - 6 ? @out_of_date_empire = 'True' :
      @day_of_week == 'Wen' && @most_recent_postcart_mailing_empire.max <= Date.today - 7 ? @out_of_date_empire = 'True' : @out_of_date_empire = 'False'

  end

  def postcard_inventory
  @inventories = Inventory.all

  @postcard_inventory = Inventory.group(:company).group(:version).group(:order).sum(:number)


  @inventories.each do |inventory|
     inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA NM' ? @date_sequoia_cpa_nm = Array.new.push(inventory['order']) : ''
     inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA RC' ? @date_sequoia_cpa_rc = Array.new.push(inventory['order']) : ''
     inventory['company'] == 'Sequoia' && inventory['version'] == 'EA NM' ? @date_sequoia_ea_nm = Array.new.push(inventory['order']) : ''
     inventory['company'] == 'Sequoia' && inventory['version'] == 'EA RC' ? @date_sequoia_ea_rc = Array.new.push(inventory['order']) : ''
     inventory['company'] == 'Empire' && inventory['version'] == 'Empire RC' ? @date_empire_rc = Array.new.push(inventory['order']) : ''
  end

  @postcard_mailings.each do |sent|
     sent['company'] == 'Sequoia' && sent['version'] == 'CPA NM' ? @used_sequoia_cpa_nm = Array.new.push(sent['number_sent']) : ''
     sent['company'] == 'Sequoia' && sent['version'] == 'CPA RC' ? @used_sequoia_cpa_rc = Array.new.push(sent['number_sent']) : ''
     sent['company'] == 'Sequoia' && sent['version'] == 'EA NM' ? @used_sequoia_ea_nm = Array.new.push(sent['number_sent']) : ''
     sent['company'] == 'Sequoia' && sent['version'] == 'EA RC' ? @used_sequoia_ea_rc = Array.new.push(sent['number_sent']) : ''
     sent['company'] == 'Empire' && sent['version'] == 'Empire RC' ? @used_empire_rc = Array.new.push(sent['number_sent']) : ''
  end

  @inventories.each do |inventory|
    inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA NM' ? @inventory_sequoia_cpa_nm = Array.new.push(inventory['number']) : ''
    inventory['company'] == 'Sequoia' && inventory['version'] == 'CPA RC' ? @inventory_sequoia_cpa_rc = Array.new.push(inventory['number']) : ''
    inventory['company'] == 'Sequoia' && inventory['version'] == 'EA NM' ? @inventory_sequoia_ea_nm = Array.new.push(inventory['number']) : ''
    inventory['company'] == 'Sequoia' && inventory['version'] == 'EA RC' ? @inventory_sequoia_ea_rc = Array.new.push(inventory['number']) : ''
    inventory['company'] == 'Empire' && inventory['version'] == 'Empire RC' ? @inventory_empire_rc = Array.new.push(inventory['number']) : ''
  end

  @inventories.each do |inventory|
    inventory['company'] == "Sequoia" && inventory['version'] == "CPA NM" && inventory['order'] == @date_sequoia_cpa_nm.max ? @number_sequoia_cpa_nm = Array.new.push(inventory['number']) : ''
    inventory['company'] == "Sequoia" && inventory['version'] == "CPA RC" && inventory['order'] == @date_sequoia_cpa_rc.max ? @number_sequoia_cpa_rc = Array.new.push(inventory['number']) : ''
    inventory['company'] == "Sequoia" && inventory['version'] == "EA NM" && inventory['order'] == @date_sequoia_ea_nm.max ? @number_sequoia_ea_nm = Array.new.push(inventory['number']) : ''
    inventory['company'] == "Sequoia" && inventory['version'] == "EA RC" && inventory['order'] == @date_sequoia_ea_rc.max ? @number_sequoia_ea_rc = Array.new.push(inventory['number']) : ''
    inventory['company'] == "Empire" && inventory['version'] == "Empire RC" && inventory['order'] == @date_empire_rc.max ? @number_empire_rc = Array.new.push(inventory['number']) : ''
  end

  @remaining_inventory_sequoia_cpa_nm = (@inventory_sequoia_cpa_nm.sum - @used_sequoia_cpa_nm.sum)
  @remaining_inventory_sequoia_cpa_rc = (@inventory_sequoia_cpa_rc.sum - @used_sequoia_cpa_rc.sum)
  @remaining_inventory_sequoia_ea_nm = (@inventory_sequoia_ea_nm.sum - @used_sequoia_ea_nm.sum)
  @remaining_inventory_sequoia_ea_rc = (@inventory_sequoia_ea_rc.sum - @used_sequoia_ea_rc.sum)
  @remaining_inventory_empire_rc = (@inventory_empire_rc.sum - @used_empire_rc.sum)

  @remaining_inventory = Array.new.push(@remaining_inventory_sequoia_cpa_nm, @remaining_inventory_sequoia_cpa_rc, @remaining_inventory_sequoia_ea_nm, @remaining_inventory_sequoia_ea_rc, @remaining_inventory_empire_rc)

end

end
