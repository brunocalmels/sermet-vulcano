Rails.application.routes.draw do

  get '/clima/dia=:dia', to: 'home#show_json'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
