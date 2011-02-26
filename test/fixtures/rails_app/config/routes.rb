RailsApp::Application.routes.draw do

  devise_for :devise_users
  match "/" => redirect("/admin")
  root :to => "welcome#index"

end
