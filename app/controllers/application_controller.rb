class ApplicationController < ActionController::Base
  include Pagy::Backend
  def add_token(num, event, user_id)
    user = User.find_by(id: user_id)
    if user.token
      token = user.token.increment(:balance, num)
    else
      token = user.create_token(balance: num)
    end
    user.token_changes.create(amount: num, event:, token_id: token.id)
  end

  def custom_authenticate_user!
    unless user_signed_in?
      flash[:notice] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end

end