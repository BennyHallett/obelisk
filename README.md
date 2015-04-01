obelisk
=======

Static Site Generator written in Elixir.

[![Build Status](https://travis-ci.org/BennyHallett/obelisk.svg?branch=master)](https://travis-ci.org/BennyHallett/obelisk)
[![Package](http://img.shields.io/hexpm/v/obelisk.svg)](https://hex.pm/packages/obelisk)

## Goals

* **Fast**. Static websites can take a long time to generate when they start to grow large.
obelisk should take advantage of Elixir's multithreaded behaviour to increase this speed.
* **Simple, Obvious**. It should be very straight forward to add new content and modify the
way that your site works.
* **Templatable**. It should be possible to store templates in github repos and reference them
directly, allowing modification of the look and feel of a site instantaneously with no manual
installation.

## Creating a new obelisk project

To create a new obelisk project, we use `mix`

    $ mix new blog

We then modify our dependencies within `mix.exs` to include obelisk, as well as the Erlang
library yamerl.

    defp deps do
      [{ :obelisk, "~> 0.7.1" },
       { :yamerl, github: "yakaz/yamerl"}]
    end

Next we need to download obelisk and compile it

    $ mix deps.get
    $ mix deps.compile

Now for the fun stuff, we can initialize our obelisk project

    $ mix obelisk init

We can build our obelisk project now. It will look pretty basic without modifications to the layout
(explained below), and some content.

    $ mix obelisk build

Once our project is built, we can check it out by starting the server.

    $ mix obelisk server

Now browse to `http://localhost:4000`

## Structure

Now that we've got our project, you will notice that an obelisk project is set
out with the following structure

    /
    /site.yml
    /themes/
    /themes/default/
    /themes/default/assets/
    /themes/default/assets/css/
    /themes/default/assets/js/
    /themes/default/assets/img/
    /themes/default/layout
    /posts/
    /drafts/
    /pages/

## Creating a new post

Obelisk expects blog post content to be located in the `/posts` directory, with filenames using the format `YYYY-mm-dd-post-title.markdown`. Any file matching this pattern will be processed and built into the `/build` directory.

You can use the `post` command to quickly create a new post with todays date, although creating the file manually will also work.

    $ mix obelisk post "New obelisk feature"

## Creating a draft

Just like the post above us, we can create a draft. Drafts are intended to hold works in progress, and won't be compiled into the `/build` directory when running the build command.

Again, the `draft` command can be used to quickly create a new draft, although creating the file manually will also work.

    $ mix obelisk draft "Still working on this"

## Creating a page

Pages are non-temporal content, such as an about page, which are built in the same way as posts, but not included in the site's RSS feed. These files can have any name, and need not start with a date stamp. For example `./pages/about-me.markdown` is a fine filename to use.

Currently there is no command to create a page, however creating a file under `./pages` will work.

## Front matter

Like other static site generators, posts should include front matter at the top of each file.

    ---
    title: My brand new blog post
    img: relative/path/to/bobby.png
    author: Bobby Tables
    twitter: littlebobbytables
    ---

    Post content goes here

Now within the `post.eex` template, which we'll talk about a bit further down, we can access these value like this:

    <div class="author">
      <a href="http://twitter.com/#{@frontmatter.twitter}">
        <img src="#{@frontmatter.img}" />
        <%= @frontmatter.author %>
      </a>
    </div>

## Themes

Since Obelisk v0.9.0, you are now able to customize your site with various
themes. These themes are stored in the `/themes/` directory, each in their own
individual directory.

After the init task is run, you will have access to the default theme, in:

    /themes/default/

You can have multiple themes under the `themes` directory. The theme which is
used at build time is determined by the `theme` setting in `./site.yml`

    ---
    ...
    theme: default
    ...

### Local Themes

Local themes are those that you have created yourself and not yet shared with
the world. A new theme can be created by making a new directory under `/themes`
and including the required files and directories

    /themes/<themename>/
    /themes/<themename>/assets/
    /themes/<themename>/assets/css/
    /themes/<themename>/assets/js/
    /themes/<themename>/assets/img/
    /themes/<themename>/layout

Enable the theme by selecting it in `site.yml` as shown above.

### Github Themes

If your theme is hosted on [Github](https://github.com) you can have Obelisk
automatically include that theme for you without having to manually include it
in your `/themes` directory.

In your `site.yml`, use the `user/repo` form common to Github repositories and
Obelisk will do the rest when you run `$ mix obelisk build`

    ---
    theme: "github_user/obelisk_theme"
    ...

>> Note: You'll need a native git client installed to clone the repository. It
>> will also need to be publicly accessible.

### Themes in other Git repositories

If your theme is in a Git repository, but not hosted on Github, never fear.
Obelisk will still handle your theme. Just include the full url to your theme
repository and Obelisk will work similarly to the way it does for Github
repositories.

    ---
    theme: "http://example.com/user/repo.git"
    ...

>> Note: You'll need a native git client installed to clone the repository. It
>> will also need to be publicly accessible.

## The asset "pipeline"

The asset "pipeline" is extremely simple at this stage. Anything under your `/themes/$THEME/assets` directory is copied to `/build/assets` when the `mix obelisk build` task is run.

## Layouts

Everything under the `/themes/$THEME/layout` directory is used to build up your site. You have the option of using either the standard [Elixir templating library, Eex](http://elixir-lang.org/docs/v1.0/eex/), or [haml](http://haml.info/).

Both templating libraries are available out of the box, with no configuration
required. They can also be both used within the same project.

Which renderer to use is decided based on the extension of the template file:

* _eex_ will use the eex renderer
* _html.eex_ will use the eex renderer
* _haml_ will use the haml renderer
* _html.haml_ will use the haml renderer

`post.eex` (or similar) is the template which wraps blog post content. The `@content` variable is used within this template to specify the location that the converted markdown content is injected.

`page.eex` (or similar) is the template which wraps page content. The `@content` variable is used within this template to specify the location that the converted markdown content is injected.

`index.eex` (or similar) is the template which wraps your index page, which for now is intented to hold the list of blog posts. This template provides 3 variables. Similar to the post template, the index template provides `@content`, which is the list of blog posts (at this stage as html links). The other two variables, `@next` and `@prev` provide links to move between index pages. Each index page contains 10 blog posts, ordered from newest to oldest. The pages are created with the following pattern:

    index.html
    index2.html
    ...
    index8.html

`layout.eex` (or similar) is the template which wraps every page. This is the template that should include your `<html>`, `<head>` and `<body>` tags. This template provides 3 variables also. Again, the `@content` variable is provided, which specifies where to inject the content from whichever page is being built. Additionally, the `@css` and `@js` variables are provided, which include the html markdown for all of the files (not folders) directly under `/build/assets/css` and `/build/assets/js` respectively. These files are written to the page in alphabetical order, so if a particual order is required (i.e reset.css first), then the current solution is to rename the files to match the order in which they should be imported:

    /assets/css/0-reset.css
    /assets/css/1-layout.css
    /assets/css/2-style.css


