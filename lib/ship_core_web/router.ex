defmodule ShipCoreWeb.Router do
  use ShipCoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShipCoreWeb do
    pipe_through :api

    get "/ping", TestController, :ping
    get "/new-ship", TestController, :new_ship
    # get "/ships", TestController, :get_ships

  end


  scope "/api/v1/ships", ShipCoreWeb do
    pipe_through :api

    get "/", Ships, :get_all_ships

    get "/new", Ships, :get_ship_type

    get "/options", Ships, :get_ships_options

    get "/:id", Ships, :get_ship
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ship_core, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ShipCoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
