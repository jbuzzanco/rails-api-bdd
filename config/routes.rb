Rails.application.routes.draw do
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  post :update, params: { :id => 12 }
  resources :users, only: [:index, :show]
  resources :articles, only: [:index, :show, :destroy, :update, :create]
end
