class AuthenticationController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.js do
      end
    end
  end

  def create
    user = User.where(login: user_params[:login]).
      where(password: user_params[:password]).first

    if user # && proper redirect domain || default
      self.current_user = user
      # generate token if cross-domain
      # redirect properly
    else
      # error
    end
  end

  protected

  def user_params
    params.require(:user).permit(:login, :password)
  end
end
