local tasks ={}



local base_str = g._(...)

tasks.find = require(base_str.."find")
tasks.chop = require(base_str.."chop")
tasks.build = require(base_str.."build")

return tasks