local village = class_base:extend()
local village_count = 0


function village:new(x, y)
    self.name = "village"..village_count
    self.pos = g.lib.base_type.pos(x,y)

    self.buildings  = {}
    self.mill = nil
    self.mill_in_progress = false

    self.campfire = nil
    self.campfire_in_progress = false

    self.population = 0
    self.population_cap = 1
    self.population_in_progress = 0

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
    if self.population_cap + self.population_in_progress <= self.population then
        --print("pop stats",self.population_cap,self.population_in_progress,self.population)
        return g.tasks.build("house",who,self)
    elseif self.campfire == nil and self.campfire_in_progress == false then
      self.campfire_in_progress = true
      return g.tasks.build("campfire",who,self)
    elseif self.mill == nil and self.mill_in_progress == false then
        self.mill_in_progress = true
        who.villager.job = g.jobs.farmer(who)
        return g.tasks.build("mill",who,self)
    elseif self.storage.wood < 100 then
        return g.tasks.chop(who)
    elseif self.storage.stone < 100 then
        return g.tasks.pick(who)
    else
      return g.tasks.wander(who)
      --return g.tasks.chop(who)
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
    print("building ",what)
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

function village:update()
    if self.mill then self.mill:update() end
end

return village


