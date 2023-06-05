Rails.application.routes.draw do
  get 'rooms/messages'
  get 'searches/search_result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get 'home/about'=>'homes#about'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update,] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers' ,as: 'followers'
  end
  
  get"search" => "searches#search"
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end