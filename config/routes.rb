ZendeskSsoAuthentication::Application.routes.draw do
  get '/protected' => 'protected#index'
  get '/auth' => 'authentication#index'

  root to: 'public#index'
end
