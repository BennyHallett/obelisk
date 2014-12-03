defmodule Obelisk.Store do

  @doc """
  Start the store
  """
  def start_link do
    Agent.start_link( fn ->
      store = HashDict.new
      store = HashDict.put(store, :posts, [])
      store = HashDict.put(store, :pages, [])
      store = HashDict.put(store, :layouts, %{
        layout: Obelisk.Layout.layout,
        post:   Obelisk.Layout.post,
        page:   Obelisk.Layout.page,
        index:  Obelisk.Layout.index
      })
      store
    end)
  end

  @doc """
  Add a set of posts to the store
  """
  def add_posts(store, posts) do
    current = Agent.get(store, &HashDict.get(&1, :posts))
    Agent.update(store, &HashDict.put(&1, :posts, current ++ posts))
  end

  @doc """
  Retrieve list of posts from store
  """
  def get_posts(store) do
    Agent.get(store, &HashDict.get(&1, :posts))
  end

  @doc """
  Add a set of pages to the store
  """
  def add_pages(store, pages) do
    current = Agent.get(store, &HashDict.get(&1, :pages))
    Agent.update(store, &HashDict.put(&1, :pages, current ++ pages))
  end

  @doc """
  Retrieve list of pages from store
  """
  def get_pages(store) do
    Agent.get(store, &HashDict.get(&1, :pages))
  end

  @doc """
  Retrieve layouts from store
  """
  def get_layouts(store) do
    Agent.get(store, &HashDict.get(&1, :layouts))
  end

end
