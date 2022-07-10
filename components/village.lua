local village = class_base:extend()
local village_count = 0


function village:new(x, y)
    self.name = "village"..village_count
    self.pos = g.lib.base_type.pos(x,y)

    self.buildings  = {}
    self.population = 0

    self.population_cap = 1

    self.storage = {
                    wood = 0,
                    stone = 0,
                    food = 0,
                    }

    village_count = village_count+1
    print("pos",x,y)
    print("village pos",self.pos.x,self.pos.y)
end


function village:get_task(who)
    if self. population_cap <= self.population then
        return g.tasks.build("house",who,self)
    end
end

function village:check_resources(ressource)
    if self.storage[ressource] then
        return  self.storage[ressource]
    else
        return 0
    end
end


function village:add_building(what,where)
    local new_building = g.lib.buildings[what](where,self)
    table.insert(self.buildings, new_building )
    return new_building
end


function village:add_resource(ressource,num)
    self.storage[ressource] = self.storage[ressource]+num
end

function village:get_ressource(ressource,num)
    self.storage[ressource] = self.storage[ressource]-num
end

return village