defmodule EkzerAdd.Exercice do
  use GenServer

  @name __MODULE__

  def start_link(type) do
    {:ok, _exercice_pid} = GenServer.start_link(@name, type)
  end

  # INTERFACE

  def new_exercise(type), do: start_link(type)

  def get_state(pid) do
    state = GenServer.call(pid, :state)
    {:ok, state}
  end

  def get_entries(exercise_pid) do
    entries = GenServer.call(exercise_pid, :entries)
    {:ok, entries}
  end

  def get_exercise_value(exercise_pid, value) do
    result = GenServer.call(exercise_pid, {:get, value})
    {:ok, result}
  end

  def add_common_infos(exercice_pid, params) do
    GenServer.cast(exercice_pid, {:add_common, params})
    {:ok, :success}
  end

  def add_specific_infos(exercise_pid, type, infos) do
    GenServer.cast(exercise_pid, {:add_specific, type, infos})
    {:ok, :success}
  end

  # CALLBACKS

  def init(type) do
    initial_state = exercice_type(type)
    {:ok, initial_state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:entries, _from, state) do
    [_head | entries] = Map.keys(state)
    {:reply, entries, state}
  end

  def handle_call({:get, value}, _from, state) do
    result = Map.get(state, value)
    {:reply, result, state}
  end

  def handle_cast({:add_common, params}, state) do
    common_fields = Enum.reduce(params, state.common_fields, fn {key, value}, acc -> 
        atom_key = String.to_atom(key)
        %{ acc | atom_key => value }
    end)
    new_state = Map.put(state, :common_fields, common_fields)
    IO.inspect new_state
    {:noreply, new_state}
  end

  def handle_cast({:add_specific, :classer, infos}, state) do
    colonnes = Map.put(state.specific_fields, :colonnes, infos)
    new_state = Map.put(state, :specific_fields, colonnes)
    {:noreply, new_state}
  end

  def handle_cast({:add_specific, :quizz, infos}, state) do
    questions = state.specific_fields.questions
    new_questions = [ infos | questions ]
    specific_fields = Map.put(state.specific_fields, :questions, new_questions)
    new_state = Map.put(state, :specific_fields, specific_fields)
    {:noreply, new_state}
  end

  # HELPERS

  defp exercice_type(:completer) do
    %EkzerAdd.Type.Completer{}
  end

  defp exercice_type(:associer) do
    %EkzerAdd.Type.Associer{}
  end

  defp exercice_type(:classer) do
    %EkzerAdd.Type.Classer{}
  end

  defp exercice_type(:prelever) do
    %EkzerAdd.Type.Prelever{}
  end

  defp exercice_type(:quizz) do
    %EkzerAdd.Type.Quizz{}
  end

  defp exercice_type(error) do
    IO.puts("Ce type #{error} n'existe pas.")
  end
end
