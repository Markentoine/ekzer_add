defmodule EkzerAdd.Type.Prelever do
    defstruct type: :classer, 
    common_fields: %{level: nil, progression: nil, field: nil, consigne: nil, objectives: [], keywords: []},
    specific_fields: %{texte: [], prelevements: []}
end