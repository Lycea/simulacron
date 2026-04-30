local stat_handle = class_base:extend()



function stat_handle:new(parent)
    self.hunger = 100
    self.energy = 200
end

function stat_handle:update()
    self.hunger = self.hunger - 1
    self.energy = self.energy - 1

end


return stat_handle
