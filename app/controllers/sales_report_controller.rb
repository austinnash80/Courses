class SalesReportController < ApplicationController

  def sequoia_sales
    @sequoia_customers_all = SequoiaCustomer.all

    @day_sales = SequoiaCustomer.group_by_day(:purchase_date).sum(:price)
    @week_sales = SequoiaCustomer.group_by_week(:purchase_date, week_start: :mon).sum(:price)
    @month_sales = SequoiaCustomer.group_by_month(:purchase_date).sum(:price)
    @year_sales = SequoiaCustomer.group_by_year(:purchase_date).sum(:price)

    @month_over_month1 = SequoiaCustomer.group_by_month(:purchase_date).sum(:price)
    @month_over_month2 = SequoiaCustomer.group_by_month(:purchase_date, format: '%m/%y').where(:purchase_date => (Date.today.beginning_of_month - 365)..(Date.today - 365)).sum(:price)

# @key = []
@value_this_year = []
@value_last_year = []
    @month_over_month1.each do |key, value|
       # @key.push(key)
      if key.strftime('%Y') == Date.today.strftime('%Y')
       @value_this_year.push(value)
      end
      if key.strftime('%Y') == (Date.today - 365).strftime('%Y')
       @value_last_year.push(value)
      end
    end

    @month_over_month2.each do |key, value|
       @two = value
    end

  end
end
