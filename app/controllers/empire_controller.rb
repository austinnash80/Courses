class EmpireController < ApplicationController
  # before_action :authenticate_user!
  def dash
    # render('dash')
    @empire_mailings = EmpireMailing.all

    @ytd_drops = []
    @ytd_quanity = []
    @ytd_cost = []

    @empire_mailings.each do |empire_mailing|
      if empire_mailing.complete == true && empire_mailing.drop.strftime('%Y') == Date.today.year.to_s
        @ytd_cost.push(empire_mailing['cost_print'])
        @ytd_cost.push(empire_mailing['cost_postage'])
        @ytd_cost.push(empire_mailing['cost_service'])
        @ytd_quanity.push(empire_mailing['quanity_sent'])
        @ytd_drops.push(empire_mailing['drops'])
      end
    end

# @ytd_states = (1..6).group_by { |i| i%3 }
# @ytd_states = EmpireMailing.group_by { |i| i%3 }

# @ytd_states = []
# @ytd_quanties = []
# @ytd_mo = []
# @ytd_nc = []
#
# @empire_mailings.each do |empire_mailing|
# if empire_mailing.complete == true && empire_mailing.drop.strftime('%Y') == Date.today.year.to_s
#   @ytd_states.push(empire_mailing['state'])
# if empire_mailing.complete == true && empire_mailing.drop.strftime('%Y') == Date.today.year.to_s && empire_mailing.state = "NC"
#   @ytd_nc.push(empire_mailing['quanity_sent'])
# if empire_mailing.complete == true && empire_mailing.drop.strftime('%Y') == Date.today.year.to_s && empire_mailing.state = "MO"
#   @ytd_mo.push(empire_mailing['quanity_sent'])
# end
# end
# end
# end

# @h = {}
# @a =[10,13]
# @h[@ytd_states] = @ytd_quanties.sum
# @t = EmpireMailing.group_by(:state).sum(:quanity_sent)
# @h[:mo] << 10
  end
end
