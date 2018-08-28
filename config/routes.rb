Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'sequoia/dash'

  resources :date_fields
  resources :pes_courses
  resources :postcard_returns
  resources :seq_customers do
    collection {post :import}
    collection do
      get 'remove_all'
    
    end
  end
  get 'empire/dash'

  get 'empire/dash'
  resources :copyrights
  devise_for :users
  # get 'updatesheets/:id/', to: redirect("/updatesheets")
  resources :updatesheets
  resources :datasheets do
    collection {post :import}
  end
  root :to => "datasheets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
