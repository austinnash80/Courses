class SalesReportController < ApplicationController

  def postcard_return_stats
    @empire_postcard_retun_total = PostcardReturn.where(:company => 'Empire Learning').group(:postcard).count
    @sequoia_postcard_retun_total = PostcardReturn.where(:company => 'Sequoia CPE').group(:postcard).count
    @sequoia_postcard_retun_total_reason = PostcardReturn.where(:company => 'Sequoia CPE').group(:reason).count
    @empire_postcard_retun_total_reason = PostcardReturn.where(:company => 'Empire Learning').group(:reason).count
  end

  def sequoia_sales
    @sequoia_customers_all = SequoiaCustomer.all

    @day_sales = SequoiaCustomer.group_by_day(:purchase_date).sum(:price)
    @week_sales = SequoiaCustomer.group_by_week(:purchase_date, week_start: :mon).sum(:price)
    @month_sales = SequoiaCustomer.group_by_month(:purchase_date).sum(:price)
    @year_sales = SequoiaCustomer.group_by_year(:purchase_date).sum(:price)

    @year_pie_chart_who = SequoiaCustomer.group(:who).sum(:price)
    @year_pie_chart_what = SequoiaCustomer.group(:what).sum(:price)
  end

  def sequoia_exams
    @start_of_week = Date.today.beginning_of_week
    @start_of_month = Date.today.beginning_of_month
    # - 1.month
    @end_of_month = Date.today.end_of_month
    @sequoia_exams_all = ExamResult.order(:course_number).all

    @exams_total = @sequoia_exams_all.pluck(:taken).sum

    @bar_chart_cpa_month = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'CPA').where(:week_s => @start_of_month).where('course_number < ?', 9000).where('course_number >= ?', 1000).group(:course_number).sum(:taken)



    # @exams_4weeks_cpa = ExamResult.group(:course_number).group(:who).where(:week_s => @start_of_week - 28..@start_of_week).order(:course_number).sum(:taken)
    @week_courses_cpa = @sequoia_exams_all.where(:who => 'CPA').where(:week_s => @start_of_week - 7..@start_of_week).pluck(:course_number).count
    @week_courses_ea = @sequoia_exams_all.where(:who => 'EA').where(:week_s => @start_of_week - 7..@start_of_week).pluck(:course_number).count
    @week_exams_cpa = @sequoia_exams_all.where(:who => 'CPA').where(:week_s => @start_of_week - 7..@start_of_week).pluck(:taken).sum
    @week_exams_ea = @sequoia_exams_all.where(:who => 'EA').where(:week_s => @start_of_week - 7..@start_of_week).pluck(:taken).sum

    @month_courses_cpa = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'CPA').where(:week_s => @start_of_month).pluck(:course_number).count
    @month_courses_ea = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'EA').where(:week_s => @start_of_month).pluck(:course_number).count
    @month_exams_cpa = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'CPA').where(:week_s => @start_of_month).pluck(:taken).sum
    @month_exams_ea = @sequoia_exams_all.where(:extra_s => 'Month').where(:who => 'EA').where(:week_s => @start_of_month).pluck(:taken).sum

      @week_score_cpa = []
      @week_score_ea = []
      @week_score_all = []
      @week_rating_cpa = []
      @week_courses_rated_cpa = []
      @week_rating_ea = []
      @week_courses_rated_ea = []
      @week_rating_all = []
      @week_courses_rated_all = []

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
        # Start Week
        if i['week_s'] == @start_of_week - 7
          if i['who'] == 'CPA'
            @week_score_cpa.push(i['score_avg'] * i['taken'])
            if i['rating'].nil?
            elsif
              @week_rating_cpa.push(i['rating'] * i['taken'])
              @week_courses_rated_cpa.push(i['taken'])
            end
          end
          if i['who'] == 'EA'
            @week_score_ea.push(i['score_avg'] * i['taken'])
            if i['rating'].nil?
            elsif
              @week_rating_ea.push(i['rating'] * i['taken'])
              @week_courses_rated_ea.push(i['taken'])
            end
          end
          if i['rating'].nil?
          elsif
            @week_rating_all.push(i['rating'] * i['taken'])
            @week_courses_rated_all.push(i['taken'])
          end
          @week_score_all.push(i['score_avg'] * i['taken'])
          # @week_rating_all.push(i['rating'] * i['taken'])
        end
      end
      # End Week

  end
end
