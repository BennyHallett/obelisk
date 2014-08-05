defmodule BuildTaskTest do
  use ExUnit.Case

  setup do
    TestHelper.cleanup
    on_exit fn -> TestHelper.cleanup end
  end

  test "Build task compiles posts into the build dir" do
    Obelisk.Tasks.Init.run([])
    Enum.each(10..15, fn day -> create_post day end)
    Obelisk.Tasks.Build.run([])

    Enum.each(10..15, fn day -> assert File.exists?("./build/#{filename(day)}.html") end)
  end

  test "Index page doesnt include next link on last page" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Tasks.Build.run([])

    assert !String.contains? File.read!("./build/index.html"), "<a href=\"index2.html\">Next Page</a>"
  end

  test "Build task copies assets into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Tasks.Build.run([])

    assert File.dir? "./build/assets"
    assert File.dir? "./build/assets/css"
    assert File.dir? "./build/assets/js"
    assert File.dir? "./build/assets/img"
  end

  defp filename(day) do
    "2014-01-#{day}-post-with-day-#{day}"
  end

  defp create_post(day) do
    File.write("./posts/#{filename(day)}.markdown", content)
  end

  defp content do
    """
    ---
    title: This is the heading
    description: This is the desc
    ---

    * And
    * A
    * List
    * Of
    * Things

    `and some inline code` for good measure
    """
  end

end
