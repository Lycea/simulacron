local build = class_base:extend()

local function point_in_circle(base_point , range, angle)
    local x = range*math.sin(math.rad(angle))+base_point.x
    local y = range*math.cos(math.rad(angle))+base_point.y
    
    return g.lib.base_types.pos(x, y)
end


function build:new(what,who,village_ref)
    self.parent = who
    self.building = what
    self.build_pos = nil
    self._village = village_ref

    self._checked_components = false
    self._build_time = 7

    local radius   = math.floor(love.math.random(1, 10))
    local angle    = love.math.random(0, 360)
    local pos      = point_in_circle(self._village.pos, radius, angle )
    pos.x = math.floor(pos.x)
    pos.y = math.floor(pos.y)
    
    self.tmp_building = self._village:add_building(what, pos)
end

function build:update()
    if self._checked_components == false then
        self._recipie = g.lib.recipies[self.building]
        
        for resource , amount in pairs(self._recipie) do
            if self._village:check_resources(resource) < amount then
                table.insert(self.parent.villager.tasks, g.tasks.chop(self.parent))
                return  
            end
        end
        self._checked_components = true
        
        for resource, amount in pairs(self._recipie) do
            self._village:get_ressource(resource,amount)
        end
        
        self.parent.mover:set_goal(self.tmp_building.pos)
    end
    
    if self.parent.mover:done() == false then
      return
    end
    
    
    self._build_time = self._build_time - 1
    if self._build_time == 0 then
        self.tmp_building:finish()
        return true
    end
end





return build