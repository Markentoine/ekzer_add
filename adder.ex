defmodule EkzerAdd.Adder do
  use GenServer

  @name __MODULE__

  def start_link(init_args) do
    # you may want to register your server with `name: __MODULE__`
    # as a third argument to `start_link`
    GenServer.start_link(@name, [init_args])
  end

  # INTERFACE

  def register_exercise(adder_pid, exercise_pid) do
    GenServer.cast(adder_pid, {:register, exercise_pid})
  end

  def get_exercises_pids(adder_pid), do: GenServer.call(adder_pid, :index)

  # CALLBACKS

  def init(_args) do
    initial_state = []
    {:ok, initial_state}
  end

  def handle_cast({:register, exercise_pid}, exercises) do
    exercises = [exercise_pid | exercises]
    {:noreply, exercises}
  end

  def handle_call(:index, _from, exercises) do
    {:reply, exercises, exercises}
  end
end
