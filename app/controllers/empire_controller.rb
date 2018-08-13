class EmpireController < ApplicationController
  before_action :authenticate_user!
  def dash
    render('dash')
  end
end
