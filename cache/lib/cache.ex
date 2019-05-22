defmodule Cache do
  use GenServer

  @name C

  # client
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def write(key, values) do
    GenServer.cast(@name, {:write, key, values})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def get() do
    GenServer.call(@name, :get)
  end

  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  def clear() do
    GenServer.cast(@name, :clear)
  end

  def exist?(key) do
    GenServer.call(@name, {:exist, key})
  end

  # server
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:exist, key}, _from, state) do
    {:reply, Map.has_key?(state, key), state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:read, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_cast({:write, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  def handle_cast(:clear, _state) do
    {:noreply, %{}}
  end
end
