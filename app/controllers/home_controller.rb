class HomeController < ApplicationController
  
  def auth_modal
    render turbo_stream: turbo_stream.replace('user_sign', partial: 'layouts/auth_modal')
  end
end
