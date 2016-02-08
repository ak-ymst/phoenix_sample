defmodule PhoenixSample.PageController do
  use PhoenixSample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
