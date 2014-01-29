ZendeskSsoAuthentication::Application.routes.draw do
  get '/public' => 'public#index'
  get '/protected' => 'protected#index'
  get '/auth' => 'authentication#index'
end
