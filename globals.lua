local globals ={}
g={}
--global helper function to help with importing in sub folders ...
function globals._(txt)
    return txt:gsub("[.][^.]*$","").."."
end

g._ = globals._
------------------
-- LIB IMPORTS
------------------
globals.lib ={}
globals.lib.base_type = require("helper.base_types")

globals.lib.entity_states = require("components.entity_states.entity_states")
globals.lib.entity = require("components.entity")

globals.lib.movements={random = require("components.movements.random")}







-----------------
-- VARS
-----------------

globals.var = {}
globals.var.entitys ={}
globals.var.map ={}



return globals