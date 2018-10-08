Rails.application.routes.draw do
  resources :email_campaigns
  resources :inventories
  resources :postcard_mailings
  resources :tx_royalties
  resources :empire_mailings
  resources :mailings do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end
  resources :tasks
  # resources :sequoia_customers
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'sequoia/dash'
  get 'sequoia/dash_ashley'

  resources :date_fields
  resources :pes_courses
  resources :postcard_returns
  get 'sequoia_customers/index'
  get 'sequoia_customers/import' => 'sequoia_customers#my_import'
  resources :sequoia_customers do
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
