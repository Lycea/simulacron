local wander = class_base:extend()

function wander:new(parent)
    self.parent    = parent
    self.goal      = nil
end

local function point_in_circle(base_point , range, angle)
    local x = range*math.sin(math.rad(angle))+base_point.x
    local y = range*math.cos(math.rad(angle))+base_point.y
    
    return g.lib.base_types.pos(x, y)
end


function wander:update()
    --print("updating find....")
    if self.goal == nil then
        
        
        local radius   = math.floor(love.math.random(1, 10))
        local angle    = love.math.random(0, 360)
        local pos      = point_in_circle(self.parent.villager.village.pos, radius, angle )
        pos.x = math.floor(pos.x)
        pos.y = math.floor(pos.y)


        self.goal = pos
        
        self.parent.mover:set_goal(self.goal)
    end

    if self.parent.mover:done() then
        --print("mover done")
        --self.on_finish["function"](self.on_finish["class"],  self._found_obj)
        return true
    end

    
end
return wander