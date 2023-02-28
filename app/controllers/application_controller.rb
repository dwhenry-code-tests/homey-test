class ApplicationController < ActionController::Base
  def current_user
    if cookies[:user]
      user = User.find_by(id: cookies[:user])
      return user if user
    end

    user = User.create
    cookies[:user] = user.id
    user
  end
end
