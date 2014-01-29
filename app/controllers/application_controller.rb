class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ensure_account_or_brand
  attr_accessor :current_account, :current_brand

  protected

  def ensure_account_or_brand
    domain = request.host

    if domain =~ /\A(\w+).localhost\z/
      self.current_account = Account.where(subdomain: $1).first
    else
      self.current_brand = Brand.where(domain: domain).first
      self.current_account = current_brand.account
    end

  end
end
