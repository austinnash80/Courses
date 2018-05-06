Rails.application.routes.draw do
  devise_for :users
  resources :updatesheets
  resources :datasheets do
    collection {post :import}
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
