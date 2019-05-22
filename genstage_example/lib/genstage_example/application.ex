defmodule GenstageExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  import Supervisor.Spec, warn: false

  use Application

  def start(_type, _args) do
    children = [
      worker(GenstageExample.Producer, [0]),
      worker(GenstageExample.ProducerConsumer, []),
      worker(GenstageExample.Consumer, [], id: 1),
      worker(GenstageExample.Consumer, [], id: 2)
    ]

    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
