# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
    user = User.find_by(confirmation_token: params[:confirmation_token])

    if user.confirmed?
      if user.token.nil?
        token = user.create_token(balance: 1000)
      else
        token = user.token.increment!(:balance, 1000)
      end
      user.token_changes.create(amount: 1000, event: 'verify email', token_id: token.id)
    end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
