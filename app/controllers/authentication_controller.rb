class AuthenticationController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        if current_brand
          @csrf_key = Digest::MD5.hexdigest([form_authenticity_token, current_brand.id, current_account.id, SecureRandom.hex(64)].join(''))
          REDIS.set(@csrf_key, form_authenticity_token)
        end
      end

      format.js do
        if current_user
          brand = Brand.where(id: params[:brand_id]).first
          render nothing: true unless brand

          @token = Digest::MD5.hexdigest([current_user.id, brand.id, SecureRandom.hex(64)].join(''))
          REDIS.set(@token, current_user.id)

          if params[:return_to].blank?
            @redirect = protected_url(host: brand.domain, token: @token)
          else
            @redirect = URI.parse(params[:return_to])

            if valid_redirect?(brand, @redirect)
              @redirect.query = { token: @token }.to_query
            else
              # @redirect = nil
              render nothing: true
            end
          end
        else
          render nothing: true
        end
      end
    end
  end

  def create
    brand = Brand.where(id: params[:brand_id]).first if params[:brand_id]
    user = User.where(login: user_params[:login]).
      where(password: user_params[:password]).first

    claimed_csrf = params[:authenticity_token]

    actual_csrf = if brand && params[:csrf_key]
      REDIS.get(params[:csrf_key])
    else
      form_authenticity_token
    end

    if user && claimed_csrf == actual_csrf
      self.current_user = user

      if params[:return_to].blank?
        redirect_to protected_path
      else
        redirect = URI.parse(params[:return_to])

        if valid_redirect?(brand, redirect)
          if brand
            key = Digest::MD5.hexdigest([user.id, brand.id, SecureRandom.hex(64)].join(''))
            REDIS.set(key, user.id)
            redirect.query = { token: key }.to_query
          end

          redirect_to redirect.to_s
        else
          # error
        end
      end
    else
      # error
    end
  end

  protected

  def user_params
    params.require(:user).permit(:login, :password)
  end

  def valid_redirect?(brand, uri)
    (!brand && uri.host == request.host) || brand.domain == uri.host
  end
end
