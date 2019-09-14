defmodule EkzerAdd.Interface do
  alias EkzerAdd.{Exercice, Adder}

  def start_add() do
    {:ok, _pid} = EkzerAdd.Supervisor.start_child()
  end

  def create_exercise(type), do: EkzerAdd.Exercice.new_exercise(type)

  def get_entries(exercise_pid), do: Exercice.get_entries(exercise_pid)

  def register_exercise(adder_pid, exercise_pid),
    do: Adder.register_exercise(adder_pid, exercise_pid)

  def get_exercises_pids(adder_pid), do: Adder.get_exercises_pids(adder_pid)

  def get_exercise_value(exercise_pid, value),
    do: Exercice.get_exercise_value(exercise_pid, value)

  def add_common_infos(exercise_pid, params), do: Exercice.add_common_infos(exercise_pid, params)

  def add_specific_infos(exercise_pid, type, infos),
    do: Exercice.add_specific_infos(exercise_pid, type, infos)
end
