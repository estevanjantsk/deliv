defmodule DelivWeb.Router do
  use DelivWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: DelivWeb.AuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: DelivWeb.AuthErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DelivWeb do
    pipe_through [:browser, :not_authenticated]

    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", DelivWeb do
    pipe_through [:browser, :protected]

    get "/profile/edit", RegistrationController, :edit, as: :profile_edit
    put "/profile/edit", RegistrationController, :update, as: :profile_edit
    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/", DelivWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", DelivWeb do
    pipe_through [:browser, :protected]

    get "/admin", AdminController, :show
  end

  scope "/admin", DelivWeb.Admin, as: :admin do
    pipe_through [:browser, :protected]

    resources "/restaurants", RestaurantController, only: [:edit, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", DelivWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DelivWeb.Telemetry
    end
  end
end
