local tasks ={}



local base_str = g._(...)

tasks.create_field = require(base_str.."create_field")
tasks.tend_field = require(base_str.."tend_field")

tasks.find = require(base_str.."find")
tasks.chop = require(base_str .. "chop")
tasks.pick = require(base_str .. "pick")
tasks.build = require(base_str .. "build")
tasks.wander = require(base_str.."wander")

return tasks
