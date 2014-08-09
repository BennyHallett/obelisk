obelisk
=======

Static Site Generator written in Elixir.

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
      [{ :obelisk, "~> 0.2.1" },
       { :yamerl, github: "yakaz/yamerl"]
    end

Next we need to download obelisk and compile it

    $ mix deps.get
    $ mix deps.compile

Now for the fun stuff, we can initialize our obelisk project

    $ mix obelisk init

We can build our obelisk project now. It will look pretty basic without modifications to the layout
(explained below), and some content.

    $ mix obelisk build

## Structure

Now that we've got our project, you will notice that an obelisk project is set
out with the following structure

    /
    /site.yml
    /assets/
    /assets/css/
    /assets/js/
    /assets/img/
    /posts/
    /drafts/
    /pages/
    /layout/

At the moment, the supported directories are the `assets` directory, the `layout` directory, and the `posts` directory.

## Creating a new post

Obelisk expects blog post content to be located in the `/posts` directory, with filenames using the format `YYYY-mm-dd-post-title.markdown`. Any file matching this pattern will be processed and built into the `/build` directory.

You can use the `post` command to quickly create a new post with todays date, although creating the file manually will also work.

    $ mix obelisk post "New obelisk feature"

## Creating a draft

Just like the post above us, we can create a draft. Drafts are intended to hold works in progress, and won't be compiled into the `/build` directory when running the build command.

Again, the `draft` command can be used to quickly create a new draft, although creating the file manually will also work.

    $ mix obelisk draft "Still working on this"

## Creating a page

Pages are non-temporal content, such as an about page, which are built in the same was as posts, but not included in the site's RSS feed. These files can have any name, and need not start with a date stamp. For example `./pages/about-me.markdown` is a fine filename to use.

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

## The asset "pipeline"

The asset "pipeline" is extremely simple at this stage. Anything under your `/assets` directory is copied to `/build/assets` when the `mix obelisk build` task is run.

## Layouts

Everything under the `/layout` directory is used to build up your site, and the Elixir template languate Eex is used.

`post.eex` is the template which wraps blog post content. The `@content` variable is used within this template to specify the location that the converted markdown content is injected.

`index.eex` is the template which wraps your index page, which for now is intented to hold the list of blog posts. This template provides 3 variables. Similar to the post template, the index template provides `@content`, which is the list of blog posts (at this stage as html links). The other two variables, `@next` and `@prev` provide links to move between index pages. Each index page contains 10 blog posts, ordered from newest to oldest. The pages are created with the following pattern:

    index.html
    index2.html
    ...
    index8.html

`layout.eex` is the template which wraps every page. This is the template that should include your `<html>`, `<head>` and `<body>` tags. This template provides 3 variables also. Again, the `@content` variable is provided, which specifies where to inject the content from whichever page is being built. Additionally, the `@css` and `@js` variables are provided, which include the html markdown for all of the files (not folders) directly under `/build/assets/css` and `/build/assets/js` respectively. These files are written to the page in alphabetical order, so if a particual order is required (i.e reset.css first), then the current solution is to rename the files to match the order in which they should be imported:

    /assets/css/0-reset.css
    /assets/css/1-layout.css
    /assets/css/2-style.css


