class AuthorizationController < ApplicationController

  def index

  end

  def authorization
    uri = URI('http://localhost:3000/authenticate')
    answer = Net::HTTP.post(uri, auth_params.to_query)
    result = JSON.parse(answer.body)
    if result['error']
      redirect_to authorization_path, notice: 'Ошибка авторизации! Проверьте д'\
'анные и повторите попытку!'
    else
      session[:auth_token] = result['auth_token']
      redirect_to root_path
    end
  end

  def exit
    session[:auth_token] = nil
    redirect_to root_path
  end

  private

  def auth_params
    params.permit(:email, :password).to_h
  end
end
