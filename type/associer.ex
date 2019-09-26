defmodule EkzerAdd.Type.Associer do
  defstruct type: :associer,
            common_fields: %{
              level: nil,
              progression: nil,
              field: nil,
              consigne: nil,
              objectives: [],
              keywords: []
            },
            specific_fields: %{propositions: []}
end
