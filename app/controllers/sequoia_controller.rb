class SequoiaController < ApplicationController
  def dash



@seq_customers_all = SeqCustomer.all
# @pur_date = @seq_customers_all.purchase.strftime('%a, %-d')
    # collumn sales chart - Start

    # @seq_customers_all.each do |i|
    #   i['purchase'] > 1.day.ago..Time.now.yesterday ? (

      @cpa_1 = []
      @ea_1 = []
      @ethics_1 = []
      @afsp_1 = []

      @seq_customers_all.each do |i|
        i['purchase'] > 1.week.ago..Time.now.yesterday ? (
          i['product_1'] == "1-Year CPA Membership Discounted Re-Activation" || i['product_1'] == "1-Year CPA Membership Re-Activation" ||
          i['product_1'] == "1-Year CPA Membership Renewal" || i['product_1'] == "1-Year CPA Membership Renewal (Auto-Renew)" ||
          i['product_1'] == "Unlimited CPA CPE Membership" || i['product_1'] == "Unlimited CPA CPE Membership (Auto-Renew)" ? @cpa_1.push("CPA") : ''
          i['product_1'] == "1-Year EA Membership Discounted Re-Activation" || i['product_1'] == "1-Year EA Membership Re-Activation" ||
          i['product_1'] == "1-Year EA Membership Renewal" || i['product_1'] == "1-Year EA Membership Renewal (Auto-Renew)" ||
          i['product_1'] == "Unlimited EA CPE Membership" || i['product_1'] == "Unlimited EA Membership (Auto-Renew)" ? @ea_1.push("EA") : ''
          i['product_1'] == "15-hour AFTR-Exempt Package" || i['product_1'] == "18-hour AFTR Package" ||
          i['product_1'] == "CE 100 - 11hr. AFTR Package" || i['product_1'] == "CE 200 - 8hr. AFTR-Exempt Package" ? @afsp_1.push("AFSP") : ''
          i['product_1'][0] == "9" || i['product_1'][0] == "E" ? @ethics_1.push("Ethics") : ''
      ) : ''
      end
      @cpa_1a = []
      @ea_1a = []
      @ethics_1a = []
      @afsp_1a = []

        @cpa_1a.push(@cpa_1.first, (@cpa_1.length * 149))
        @ea_1a.push(@ea_1.first, @ea_1.length * 99)
        @ethics_1a.push(@ethics_1.first, @ethics_1.length * 65.5)
        @afsp_1a.push(@afsp_1.first, @afsp_1.length * 55)

        @pie_1 = []
        @pie_1.push(@cpa_1a, @ea_1a, @ethics_1a, @afsp_1a)
  # collumn sales chart - Start

end 
end
