local buildings ={}


local base_str = g._(...)

buildings.house = require(base_str.."house")
buildings.mill = require(base_str.."mill")
--buildings.fireplace = require(base_str.."fireplace")


return buildings