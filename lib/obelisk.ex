defmodule Obelisk do
  use Application

  def start(_type, __args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Obelisk.Config, [nil])
    ]

    opts = [strategy: :one_for_one, name: Obelisk.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
