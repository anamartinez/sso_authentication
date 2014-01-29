class Account < ActiveRecord::Base
  def host
    subdomain + '.localhost'
  end
end
