defmodule Obelisk.Plug.IndexTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Obelisk.Plug.Index.init([])

  test "ignores sent conn" do
    conn = conn(:get, "/")
      |> Map.put(:state, :sent)
      |> Map.put(:status, 204)

    conn = Obelisk.Plug.Index.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 204
  end

  test "sends conn as-is if ./build/index.html doesn't exist" do
    conn = conn(:get, "/")
      |> Map.put(:resp_body, "Created")
      |> Map.put(:status, 201)

    conn = Obelisk.Plug.Index.call(conn, @opts)

    assert conn.state == :unset
    assert conn.status == 201
    assert conn.resp_body == "Created"
  end

  test "sends file if exists" do
    source = Path.expand("./test/fixtures/build")
    dest   = Path.expand("./build")
    File.cp_r source, dest

    conn = conn(:get, "/")

    conn = Obelisk.Plug.Index.call(conn, @opts)

    assert conn.state == :sent
    refute conn.resp_body in [nil, ""]

    File.rm_rf dest
  end
end
