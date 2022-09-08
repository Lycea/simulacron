local villager = class_base:extend()

function villager:new(parent)
    self.is_villager = true
    self.parent = parent
    self.job = nil

    self.tasks ={}
end


function villager:search_village()  
    print("searching for village...")
    for _,village in pairs(g.var.villages) do
        if self.parent.pos:distance_to(village.pos)< 20 then
            self.village = village
            self.village.population= self.village.population +1
            return
        end
    end
    -- no village is available in the vicinity, so create a new village
    local new_village = g.lib.village(self.parent.pos.x,self.parent.pos.y)
    self.village = new_village
    self.village.population= self.village.population +1
    table.insert(g.var.villages,  new_village)
end


function villager:pop_task()
    table.remove(self.tasks, #self.tasks)
end

function villager:add_task(task)
    table.insert( self.tasks, task)
end

function villager:get_task()
    if self.job then
        --print("getting job task")
        self.job:get_task()
    else
        self:add_task( self.village:get_task(self.parent) )
    end
end


function villager:update_tasks()
   --print("updating tasks...")
    
   --print(#self.tasks)
    if #self.tasks ~= 0 then
        local ret = self.tasks[#self.tasks]:update()
        if ret ~= nil then
                self:pop_task()
        end
    else
      self:get_task()
    end
end

return villager