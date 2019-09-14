defmodule EkzerAdd.Type.Quizz do
  defstruct type: :quizz,
            common_fields: %{
              level: nil,
              progression: nil,
              field: nil,
              consigne: nil,
              objectives: [],
              keywords: []
            },
            specific_fields: %{questions: []}
end
