defmodule Player do
  def loop do
    receive do
      {sender_pid, :ping} ->
        :timer.sleep(2000)
        send(sender_pid, {self(), :pong})
      {sender_pid, :pong} ->
        :timer.sleep(2000)
        send(sender_pid, {self(), :ping})
      _ ->
        IO.puts("message received")
    end
    loop()
  end
end
