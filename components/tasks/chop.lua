local chop = class_base:extend()

function chop:new(parent)
    self.parent = parent
    self.chop_target = nil
    self.wood = 0

    self.move_back = false
end

function chop:update()
    if self.move_back then
        if self.parent.mover:done() then
            self.parent.villager.village:add_resource("wood", self.wood)
            return true
        else
            return 
        end
    end

    --print("update chop...")
    if self.chop_target == nil then
        table.insert(self.parent.villager.tasks,
                     g.tasks.find("tree",self.parent,
                                  {["class"]=self,["function"]=self.set_target} 
                                    ))
    else
        local wood = self.chop_target.tree:chop()
        --tree is done
        if wood == 0 and self.wood ~= 0 then
            --self.parent.villager.village:add_resource("wood", self.wood)

            self.parent.mover:set_goal(self.parent.villager.village.pos)
            self.move_back = true
        elseif wood == 0 and self.wood == 0  then
            self.chop_target = nil
        end
        self.wood = self.wood + wood
    end
end

function chop:set_target(target)
    self.chop_target = target
end



return chop