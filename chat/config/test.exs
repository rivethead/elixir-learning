# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :chat, remote_supervisor: fn(_recipient) -> Chat.TaskSupervisor end
