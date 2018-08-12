Rails.application.routes.draw do
  root "dashboard#index"

  get "dashboard/index"
  post "dashboard/search"
  post "dashboard/purge"
end
