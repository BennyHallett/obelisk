defmodule PostTest do
  use ExUnit.Case, async: false

  test "Can properly parse md filename to post name" do
    filename = "2014-02-03-this-is-a-test.markdown"
    processed = Obelisk.Post.title(filename)
    assert processed == "This is a test"
  end

  test "separate post into front matter and content" do
    { frontmatter, content } = Obelisk.Document.parts(post_content)
    assert "---\nfront: matter\noh: yeah" == frontmatter
    assert "\nThis is the post content\n\n* And\n* A\n* List\n" == content
  end

  defp post_content do
    """
    ---
    front: matter
    oh: yeah
    ---

    This is the post content

    * And
    * A
    * List
    """
  end

end
