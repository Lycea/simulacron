local base_job = class_base:extend()

function base_job:new()
    self.job= "base_job"
end

function base_job:get_task()

end

local class_list = {}

--------------------------------
-- ALL OTHER TASKS
--------------------------------

-----------
-- FARMER
local farmer = base_job:extend()
class_list.farmer = farmer

function farmer:new(parent)
    self.job="farmer"
    self.parent = parent
end

function farmer:get_task()
    if #self.parent.villager.village.mill.plots < self.parent.villager.village.mill.max_plots then
        --print("  create a field")
        table.insert(self.parent.villager.tasks, g.tasks.create_field(self.parent))
        return
    end

    
    --print("grow count:",self.parent.villager.village.mill.grow_cnt)
    if self.parent.villager.village.mill.grow_cnt >0 then
        --print("Assigning a tending job... ("..self.parent.villager.village.mill.grow_cnt..")")
        for id,_ in pairs(self.parent.villager.village.mill.grown_plots) do
            --print("plot type")
            --print(self.parent.villager.village.mill.plots[id])
            --print("Plot id:", id)
            table.insert(self.parent.villager.tasks,
                         g.tasks.tend_field(self.parent, self.parent.villager.village.mill.plots[id], id))
            return
        end
    end
end


-----------
-- CHOPPER

return class_list