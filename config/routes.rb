Socalbouldering::Application.routes.draw do

  resources :forums do
    resources :topics do
      resources :posts
    end
  end

  devise_for :users

  root :to => 'forums#index'

end
