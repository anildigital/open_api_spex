defmodule PhoenixAppWeb.Router do
  use Phoenix.Router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(OpenApiSpex.Plug.PutApiSpec, module: PhoenixAppWeb.ApiSpec)
  end

  scope "/" do
    pipe_through(:browser)

    get("/swaggerui", OpenApiSpex.Plug.SwaggerUI,
      path: "/api/openapi",
      oauth: [
        client_id: "e2195a7487322a0f19bf",
        redirect_url: "http://localhost:4000/swaggerui/oauth2-redirect.html"
      ]
    )

    get("/swaggerui/oauth2-redirect.html", OpenApiSpex.Plug.SwaggerUIOAuth2Redirect, :show)
  end

  scope "/api" do
    pipe_through(:api)
    resources("/users", PhoenixAppWeb.UserController, only: [:index, :show])
    post("/users/:group_id", PhoenixAppWeb.UserController, :create)
    get("/openapi", OpenApiSpex.Plug.RenderSpec, :show)
  end
end
