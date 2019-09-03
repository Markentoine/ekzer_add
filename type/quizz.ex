defmodule EkzerAdd.Type.Quizz do
    defstruct type: :classer, 
    common_fields: %{level: nil, progression: nil, field: nil, consigne: nil, objectives: [], keywords: []},
    specific_fields: %{questions: []}
end