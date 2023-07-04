Rails.application.routes.draw do
  resources :tovars, only: %i[show index] do
    collection do
      get :current
    end
  end

    # root "tovars#index"
end
