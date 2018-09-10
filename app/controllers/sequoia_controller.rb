class SequoiaController < ApplicationController
  def dash



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

@t = SequoiaCustomer.group_by_year(:purchase_date, current: false, format: '%Y').sum(:price)
# @t6 = SequoiaCustomer.group_by_year(:purchase_date, format: '%Y').group(:who).sum(:price)
@t6 = SequoiaCustomer.group(:what).sum(:price)
@t7 = SequoiaCustomer.sum(:price)

@t1 = SequoiaCustomer.group_by_day(:purchase_date, last: 3, format: ('%a')).group(:who).sum(:price)
@t2 = SequoiaCustomer.group_by_day(:purchase_date, last: 3, format: ('%a')).group(:what).sum(:price)

@t3 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).group(:who).sum(:price)
@t4 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).sum(:price)
@t5 = SequoiaCustomer.group_by_month(:purchase_date, last: 3, format: ('%B')).group(:what).sum(:price)


# @d = 2.day.ago..Time.now
# # @d = 1.day.ago.strftime('%Y-%m-%d')
# @d1 = 1.day.ago..Time.now

# --- Task Section ----
@tasks = Task.all

# --- Mailing Section ----
@mailings = Mailing.all

end

end
