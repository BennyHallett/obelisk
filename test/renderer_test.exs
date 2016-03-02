defmodule RendererTest do
  use ExUnit.Case, async: true
  alias Obelisk.Renderer

  test "Test render eex" do
    content = "<h1><%= String.upcase \"hello\" %></h1>"
    expected = "<h1>HELLO</h1>"

    result = Renderer.render(content, :eex)

    assert expected == result
  end

  test "Test render haml" do
    content = "%h1 Hi there"
    expected = "<h1>Hi there</h1>"

    result = Renderer.render(content, :haml)

    assert expected == result
  end

  test "Test render eex with parameters" do
    title = "Good morning"
    content = "<h1><%= @title %></h1>"
    expected = "<h1>Good morning</h1>"

    result = Renderer.render(content, [title: title], :eex)

    assert expected == result
  end

  test "Test render haml with parameters" do
    title = "Good morning"
    content = "%h1= title"
    expected = "<h1>Good morning</h1>"

    result = Renderer.render(content, [title: title], :haml)

    assert expected == result
  end

  test "Test render/2 eex with parameters" do
    title = "Good morning"
    content = "<h1><%= @title %></h1>"
    expected = "<h1>Good morning</h1>"

    result = Renderer.render({content, :eex}, [title: title])

    assert expected == result
  end

  test "Test render/2 haml with parameters" do
    title = "Good morning"
    content = "%h1= title"
    expected = "<h1>Good morning</h1>"

    result = Renderer.render({content, :haml}, [title: title])

    assert expected == result
  end

end
