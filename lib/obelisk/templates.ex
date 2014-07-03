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

end
