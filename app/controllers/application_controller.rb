class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    current_user.email == 'austin@sequoiacpe.com' ? sequoia_dash_path : ''
    current_user.email == 'ashley@sequoiacpe.com' ? sequoia_dash_ashley_path : ''
    current_user.email == 'sabrina@sequoiacpe.com' ? sequoia_dash_sabrina_path : ''
    current_user.email == 'michael@sequoiacpe.com' ? sequoia_dash_michael_path : ''
    current_user.email == 'kyle@sequoiacpe.com' ? sequoia_dash_path : ''
    current_user.email == 'john@empirelearning.com' ? sequoia_dash_john_path : ''
  end

end
