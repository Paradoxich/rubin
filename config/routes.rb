Rails.application.routes.draw do
  resources :briefs

  get "up" => "rails/health#show", as: :rails_health_check

  root "briefs#index"
end
