defmodule PhoenixSample.Memcached do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_options = [
      name: {:local, :memcached_pool},
      worker_module: :mcd,
      size: 5,
      max_overflow: 0,
    ]

    arg = ['localhost', 11211]

    children = [
      :poolboy.child_spec(:memcached_pool, pool_options, arg)
    ]

    supervise(children, strategy: :one_for_one)
  end

  def set(key, value) do
    :poolboy.transaction :memcached_pool, &(:mcd.set(&1, key, value))
  end

  def get(key) do
    :poolboy.transaction(:memcached_pool, fn worker ->
      :mcd.get(worker, key)
      |> case do
      {:ok, resp} -> resp
      _ -> "Boom!"
      end
    end)
  end

  def delete(key) do
    :poolboy.transaction :memcached_pool, &(:mcd.delete(&1, key))
  end
end
