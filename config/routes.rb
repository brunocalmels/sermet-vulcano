Rails.application.routes.draw do

  get '/clima', to: 'home#show_json'
  get '/:dia', to: 'home#index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
