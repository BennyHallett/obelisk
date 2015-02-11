defmodule Obelisk.Templates do

  @moduledoc """
  This module contains various templates for building initial files
  for obelisk sites.
  """

  def post(title) do
    """
    ---
    title: #{title}
    description: A new blog post
    created: #{Obelisk.Date.now}
    ---

    Welcome to your brand new obelisk post.
    """
  end

  def page(title) do
    """
    ---
    title: #{title}
    description: A new page
    ---

    Welcome to your brand new page.
    """
  end

  def config do
    """
    ---
    name: A brand new static site
    url: http://my.blog.url
    description: This is my blog about things
    language: en-us
    posts_per_page: 10
    theme: default
    """
  end

  def post_template do
  """
  <div id="post">
    <h2>
      <a href="<%= @filename %>"><%= @frontmatter.title %></a>
    </h2>
    <%= @content %>
  </div>
  """
  end

  def page_template do
  """
  <div id="page">
    <%= @frontmatter.title %>
    <hr />
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
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <%= @css %>
      <%= @js %>
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
      <%= Enum.map @content, fn(post) ->
        \"\"\"
        #\{post.content}
        <hr />
        \"\"\"
      end %>
      <%= @prev %>
      <%= @next %>
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
