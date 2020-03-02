Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'cocktails', to: 'cocktails#index', as: 'cocktails'
  get 'cocktails/new', to: 'cocktails#new', as: 'new_cocktail'
  get 'cocktails/:id', to: 'cocktails#show', as: 'cocktail'
  post 'cocktails', to: 'cocktails#create'

  get 'cocktails/:cocktail_id/doses/new', to: 'doses#new', as: 'new_dose'
  post 'cocktails/:cocktail_id/doses', to: 'doses#create', as: 'cocktail_doses'
  delete 'doses/:id', to: 'doses#destroy', as: 'dose'

  # This (below)is the shorthand way to do the lines above

  # resources :cocktails, only: [:index, :new, :show,:create] do
  #     resources :doses, only: [:new, :create]
  #   end
  #   resources :doses, only: :destroy
end
