defmodule EkzerAdd.Supervisor do
    use DynamicSupervisor

    def start_link(:ok) do
        DynamicSupervisor.start_link(__MODULE__, [:ok], name: __MODULE__)
    end

    def start_child() do
        child_spec = %{
            id: EkzerAdd.Adder,
            start: {EkzerAdd.Adder, :start_link, [:ok]},
            restart: :transient,
            shutdown: :brutal_kill,
            type: :worker,
            modules: [EkzerAdd.Adder],
        }

        DynamicSupervisor.start_child(__MODULE__, child_spec)
    end

    def init([_init_args]) do
        DynamicSupervisor.init(strategy: :one_for_one)
    end
end