class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  self.request_forgery_protection_token = :authenticity_token

  before_filter :ensure_account_or_brand, :set_user, :find_user

  attr_accessor :current_account, :current_brand
  attr_reader :current_user

  helper_method :current_account, :current_brand, :current_user

  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end

  protected

  def ensure_account_or_brand
    domain = request.host

    if domain =~ /\A(\w+).localhost\z/
      self.current_account = Account.where(subdomain: $1).first
    else
      self.current_brand = Brand.where(domain: domain).first
      self.current_account = current_brand.account
    end

    render text: 'Not found', status: :not_found unless current_account
  end

  def set_user
    return unless session[:user_id]
    self.current_user = User.where(id: session[:user_id]).first
  end

  def find_user
    if token = params.delete(:token)
      user_id = REDIS.get(token)

      if user_id
        self.current_user = User.where(id: user_id).first
      end
    end
  end

  def authorize!
    unless current_user
      redirect_to auth_url(return_to: request.url)
    end
  end
end
