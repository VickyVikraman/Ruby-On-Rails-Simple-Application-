Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'crud#index' , as: :authenticated_root
      get 'users/sign_out' => 'devise/sessions#destroy'
    end
    unauthenticated do
      root 'devise/sessions#new'
    end
  end
  get "crud/index" => "crud#index"
  get "admin/index" => "admin#index"
  get "admin/download" => "admin#download"
  get "admin/show" => "admin#show"
  get "admin/excel" => "admin#excel"
  resources "admin"
  resources "crud"
end
