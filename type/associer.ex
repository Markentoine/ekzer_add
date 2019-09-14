defmodule EkzerAdd.Type.Associer do
  # defstruct type: :associer, propositions: [], level: nil, progression: nil, field: nil, objectives: [], keywords: [], consigne: nil
  defstruct type: :associer,
            common_fields: %{
              level: nil,
              progression: nil,
              field: nil,
              consigne: nil,
              objectives: [],
              keywords: []
            },
            specific_fields: %{proposition: nil, association: nil}
end
