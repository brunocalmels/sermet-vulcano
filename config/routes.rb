Rails.application.routes.draw do
  get '/clima', to: 'home#show_json'
  get '/:dia', to: 'home#index'

  root 'home#index'
end