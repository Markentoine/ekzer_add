defmodule EkzerAdd.Application do
  use Application

  def start(_type, _args) do
    IO.puts "EkzerAdd app starting..."
    {:ok, _sup_pid} = EkzerAdd.Supervisor.start_link(:ok)
  end
end
