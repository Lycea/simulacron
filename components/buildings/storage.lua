local storage = class_base:extend()

local P_SIZE = 5

function storage:new(pos)
  self.pos = pos
  self.state = "building"
  self.storage_count = 0
  self.storage_max = 20
end

function storage:draw()
  if self.state == "building" then

  elseif self.state == "done" then

  elseif self.state == "ruined" then
  end
end

function storage:update()

end

local wood_storage = storage:extend()
local rock_storage = storage:extend()
local food_storage = storage:extend()




