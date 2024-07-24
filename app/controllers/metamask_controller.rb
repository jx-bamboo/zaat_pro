class MetamaskController < ApplicationController
  protect_from_forgery with: :null_session

  def eth
    address = params[:address]
    p address, '..................'
    if user_signed_in?
      u = User.find_by(address:)
      if u.nil?
        if current_user.update(address:)
          render json: {data: "reload"} and return
        else
          render json: {data: current_user.errors.full_messages} and return
        end
      else
        render json: {data: "Address is Invalid."}
      end
    else
      p '... not signed in ...'
      user = User.find_by_address(address)
      if user
        p '... user found ...'
        sign_in(user)
        render json: {data: "reload"}
      else
        p '... user not found ...'
        user = User.new(email: rand_email, password: "123456", address:, confirmed_at: Time.now)
        respond_to do |format|
          if user.save
            sign_in(user)
            render json: {data: "reload"} and return
          else
            p user.errors.full_messages, '... user not saved ...'
            render json: {data: user.errors} and return
          end
        end
      end

    end

  end

  private

  def rand_email
  username_length = rand(6..11)  
  username = ('a'..'z').to_a.shuffle[0...username_length].join
  domain = "address.zaat"
  "#{username}@#{domain}"  
  end
end
