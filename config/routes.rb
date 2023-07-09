Rails.application.routes.draw do
  resources :tovars, only: %i[show index]

  root "tovars#index"
end
