defmodule Obelisk.Templates do

  @moduledoc """
  This module contains various templates for building initial files
  for obelisk sites.
  """

  def post do
    """
    My brand new obelisk site
    =========================

    Welcome to your brand new obelisk site.

    Blog posts go here, under the `/posts` directory. You can also put content in `/pages` and `/drafts`.

    For developers, you can share code, either `inline like this`, or:

        in a
        block like
        this

    Enjoy!
    """
  end

  def config do
    """
    ---
    name: A brand new static site

    """
  end

  def post_template do
  """
  <div id="post">
    <%= @content %>
  </div>
  """
  end

  def layout do
  """
  <!DOCTYPE html>
  <html>
    <head>
      <title>This should be replaced by whats in site.yml</title>
      <%= @css %>
    </head>

    <body>
      <div class="container">
        <h1>obelisk</h1>
        <%= @content %>
      </div>
    </body>
  </html>
  """
  end

  def index do
    """
    <div class="index">
      <%= Enum.join(@content, "\n") %>
    </div>
    """
  end

  def base_css do
    """
    body {
      margin: 0;
      padding: 0;
    }

    .container {
      width: 980px;
      margin: 0 auto;
    }
    """
  end

end
