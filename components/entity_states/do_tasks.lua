


function init(base)
    local do_tasks = base:extend()
    function do_tasks:new(parent)
        self.parent = parent    
        self.parent.mover = g.lib.movements.goal_movement(parent)
    end

    function do_tasks:on_enter()
        if self.parent.villager == nil then
            self.parent.villager = g.lib.villager(self.parent)
            self.parent.villager:search_village()

            self.parent.villager:add_task(self.parent.villager.village:get_task(self.parent))
                         
        end
        
    end
    function do_tasks:on_exit()

    end
    function do_tasks:update()
        self.parent.mover:update()
        self.parent.villager:update_tasks()
    end

    return do_tasks
end


return {init=init}