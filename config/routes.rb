Rails.application.routes.draw do
  resources :invoices, only: [:index, :show, :new, :create, :destroy] do
    member do
      post :paid
      post :refunded
      get :download
    end
  end

  root :to => "invoices#index"
end
