defmodule Server do
  use Plug.Router
  plug Plug.Static, at: "/", from: :server

  plug :match
  plug :dispatch

  get "/" do
    conn = put_resp_content_type(conn, "text/html")
    send_file(conn, 200, "app/static/index.html")
  end

  match _ do
    send_resp(conn, 400, "oops")
  end
end
