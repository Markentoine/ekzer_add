defmodule EkzerAdd.Exercice do
    use GenServer

    @name __MODULE__

    def start_link(type) do
        {:ok, _exercice_pid} = GenServer.start_link(@name, type)
    end

    #INTERFACE

    def new_exercise(type), do: start_link(type)

    def get_entries(exercise_pid) do
        entries = GenServer.call(exercise_pid, :entries)
        {:ok, entries}
    end

    def get_exercise_value(exercise_pid, value) do
        result = GenServer.call(exercise_pid, {:get, value})
        {:ok, result}
    end

    #CALLBACKS

    def init(type) do
        initial_state = exercice_type(type)
        {:ok, initial_state}
    end

    def handle_call(:entries, _from, state) do
        [_head | entries] = Map.keys(state)
        {:reply, entries, state}
    end

    def handle_call({:get, value}, _from, state) do
        result = Map.get(state, value)
        {:reply, result, state}
    end

    #HELPERS

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
        IO.puts "Ce type #{error} n'existe pas."
    end
end