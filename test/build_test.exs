defmodule BuildTaskTest do
  use ExUnit.Case

  setup do
    cleanup
    on_exit fn -> cleanup end
  end

  test "Build task compiles posts into the build dir" do
    Obelisk.Tasks.Init.run([])
    Enum.each(10..15, fn day -> create_post day end)
    Obelisk.Tasks.Build.run([])

    Enum.each(10..15, fn day -> assert File.exists?("./build/#{filename(day)}.html") end)
  end

  defp filename(day) do
    "2014-01-#{day}-post-with-day-#{day}"
  end

  defp create_post(day) do
    File.write("./posts/#{filename(day)}.markdown", content)
  end

  defp content do
    """
    This is the heading
    ===================

    * And
    * A
    * List
    * Of
    * Things

    `and some inline code` for good measure
    """
  end

  defp cleanup do
    File.rm_rf "./assets"
    File.rm_rf "./posts"
    File.rmdir "./drafts"
    File.rmdir "./pages"
    File.rmdir "./layout"
    File.rm "./site.yml"
    File.rm_rf "./build"
  end

end
