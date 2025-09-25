local pick = class_base:extend()

function pick:new(parent)
    self.parent = parent
    self.pick_target = nil
    self.stone = 0

    self.move_back = false
end

function pick:update()
    if self.move_back then
        if self.parent.mover:done() then
            self.parent.villager.village:add_resource("stone", self.stone)
            return true
        else
            return 
        end
    end

    --print("update pick...")
    if self.pick_target == nil then
        table.insert(self.parent.villager.tasks,
                     g.tasks.find("stone",self.parent,
                                  {["class"]=self,["function"]=self.set_target} 
                                    ))
    else
        local stone = self.pick_target.stone:pick()
        --tree is done
        if stone == 0 and self.stone ~= 0 then
            --self.parent.villager.village:add_resource("stone", self.stone)

            self.parent.mover:set_goal(self.parent.villager.village.pos)
            self.move_back = true
        elseif stone == 0 and self.stone == 0  then
            self.pick_target = nil
        end
        self.stone = self.stone + stone
    end
end

function pick:set_target(target)
    self.pick_target = target
end



return pick
