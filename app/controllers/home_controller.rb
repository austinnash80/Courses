class HomeController < ApplicationController
  def index
     path = case user_signed_in? && current_user.email
     when 'austin@sequoiacpe.com'
         sequoia_dash_path
       when 'ashley@sequoiacpe.com'
         sequoia_dash_ashley_path
       when 'michael@sequoiacpe.com'
         sequoia_dash_michael_path
       when 'hamdo@sequoiacpe.com'
         sequoia_dash_hamdo_path
       when 'kyle@sequoiacpe.com'
         sequoia_dash_hamdo_path
       else
         datasheets_path
     end

     redirect_to path
   end
 end
