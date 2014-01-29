ZendeskSsoAuthentication::Application.routes.draw do
  get '/protected' => 'protected#index'
  get '/auth' => 'authentication#index'
  post '/auth' => 'authentication#create'
  root to: 'public#index'
end
