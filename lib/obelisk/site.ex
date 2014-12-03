defmodule Obelisk.Site do

  def initialize do
    create_default_theme
    create_content_dirs
    Obelisk.Post.create("Welcome to Obelisk")
    File.write './site.yml', Obelisk.Templates.config
  end

  def clean do
    File.rm_rf "./build"
    File.mkdir "./build"
  end

  def create_default_theme do
    File.mkdir "./themes"
    File.mkdir "./themes/default"
    create_assets_dirs
    create_layout_dirs
  end

  defp create_assets_dirs do
    File.mkdir "./themes/default/assets"
    File.mkdir "./themes/default/assets/css"
    File.mkdir "./themes/default/assets/js"
    File.mkdir "./themes/default/assets/img"
    File.write "./themes/default/assets/css/base.css", Obelisk.Templates.base_css
  end

  defp create_content_dirs do
    File.mkdir "./posts"
    File.mkdir "./drafts"
    File.mkdir "./pages"
  end

  defp create_layout_dirs do
    File.mkdir "./themes/default/layout"
    File.write "./themes/default/layout/post.eex", Obelisk.Templates.post_template
    File.write "./themes/default/layout/layout.eex", Obelisk.Templates.layout
    File.write "./themes/default/layout/index.eex", Obelisk.Templates.index
    File.write "./themes/default/layout/page.eex", Obelisk.Templates.page_template
  end

end
