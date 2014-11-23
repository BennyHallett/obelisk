defmodule Obelisk.Plug.ServerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Obelisk.Plug.Server.init([])

  test "sends 404 for unknown response" do
    message = "Resource not found. If you're looking for the index page, try http://localhost:4000/"
    conn = conn(:get, "/unknown/response")

    conn = Obelisk.Plug.Server.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == message
  end

  test "doesn't send 404 for known files" do
    source = Path.expand("./test/fixtures/build")
    dest   = Path.expand("./build")
    File.cp_r source, dest 

    conn = conn(:get, "/")

    conn = Obelisk.Plug.Index.call(conn, @opts)

    assert conn.halted
    refute conn.resp_body in [nil, ""]
    assert conn.status == 200

    File.rm_rf dest
  end
end
