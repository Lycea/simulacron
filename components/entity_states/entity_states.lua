local entity_states ={}

entity_states._base_state =require(g._(...).."base_state")

entity_states.idle = require(g._(...).."idle").init(entity_states._base_state)

return entity_states
