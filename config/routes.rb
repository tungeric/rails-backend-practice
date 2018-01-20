Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :api, defaults: { format: :json } do
    resources :chats, only: [:index, :create]
    get '/chats/:query', to: 'chats#show', as: 'chat'
  # end
end

