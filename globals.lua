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
globals.lib.base_types = globals.lib.base_type
globals.lib.helpers   = require("helper.helpers")
globals.lib.timer     = require("helper.timer")


globals.lib.recipies = require("components.recipies")

globals.lib.entity_states = require("components.entity_states.entity_states")
globals.lib.entity = require("components.entity")

globals.lib.movements={
    random        = require("components.movements.random"),
    goal_movement = require("components.movements.goal_movement")
}

globals.lib.tasks     = require("components.tasks.tasks")
globals.lib.buildings = require("components.buildings.buildings")


globals.lib.village = require("components.village")
globals.lib.villager = require("components.villager")

globals.lib.tree =require("components.specials.tree")

globals.lib.jobs = require("components.jobs")

-----------------
-- VARS
-----------------

globals.var = {}
globals.var.entitys ={}
globals.var.map ={}

globals.tasks = globals.lib.tasks
globals.jobs  = globals.lib.jobs

globals.var.villages = {}

return globals