defmodule FrontMatterTest do
  use ExUnit.Case

  test "can parse front matter" do
    fm = Obelisk.FrontMatter.parse frontmatter
    assert fm == [{ 'title', 'awesome blog post' }]
  end

  defp frontmatter do
    "---\ntitle: awesome blog post"
  end

end
