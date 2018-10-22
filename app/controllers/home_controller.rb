class HomeController < ApplicationController
  def index
     path = case current_user.email
     when 'austin@sequoiacpe.com'
         sequoia_dash_path
       when 'ashley@sequoiacpe.com'
         sequoia_ashley_dash_path
       else
         datasheets_path
     end

     redirect_to path
   end
 end
