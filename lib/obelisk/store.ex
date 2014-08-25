defmodule Obelisk.Store do

  @doc """
  Start the store
  """
  def start_link do
    Agent.start_link( fn ->
      store = HashDict.new
      store = HashDict.put(store, :config, HashDict.new)
      store = HashDict.put(store, :posts, [])
      store
    end)
  end

  @doc """
  Save config into the store
  """
  def set_config(store, config) do
    Agent.update(store, &HashDict.put(&1, :config, config))
  end

  @doc """
  Retrieve config from store
  """
  def get_config(store) do
    Agent.get(store, &HashDict.get(&1, :config))
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

end
