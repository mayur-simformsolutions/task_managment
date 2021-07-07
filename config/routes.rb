Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do 
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "send_invitation", to: "invitations#send_invitation"
        post "accept_invitation", to: "invitations#accept_invitation"
        delete "logout", to: "sessions#logout"
      end

      # Tasks
      resources :tasks, only: [:index, :create, :destroy, :update, :show]

      # Custom routing error path
      match '*path', to: 'base#routing_error', via: %i[get post put patch delete]
      root to: 'base#routing_error'
    end
  end
end
