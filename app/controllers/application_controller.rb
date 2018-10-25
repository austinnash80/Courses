class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    current_user.email == 'austin@sequoiacpe.com' ? sequoia_dash_path : ''
    current_user.email == 'ashley@sequoiacpe.com' ? sequoia_dash_ashley_path : ''
    current_user.email == 'hamdo@sequoiacpe.com' ? sequoia_dash_hamdo_path : ''
    current_user.email == 'michael@sequoiacpe.com' ? sequoia_dash_michael_path : ''
    current_user.email == 'kyle@sequoiacpe.com' ? sequoia_dash_kyle_path : ''
  end

end
