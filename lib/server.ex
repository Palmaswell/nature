defmodule Server do
  use Plug.Router

  plug Plug.Static, at: "/", from: :server
  plug Plug.Static, at: "/src", from: :server

  plug :match
  plug :dispatch

  get "/" do
    conn = put_resp_content_type(conn, "text/html")
    send_file(conn, 200, "app/static/index.html")
  end

  # Serves JavaScript
  get "/src/:file"  do
    if String.ends_with?(file, ".bs.js") do
        conn = put_resp_content_type(conn, "text/javascript")
        send_file(conn, 200, "app/src/#{file}")
    else
        send_resp(conn, 400, "requested file #{file} is not supported")
    end
  end

  match _ do
    send_resp(conn, 400, "oops")
  end
end
