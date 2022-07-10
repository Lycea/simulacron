local chop = class_base:extend()

function chop:new(parent)
    self.parent = parent
    self.chop_target = nil
    self.wood = 0
end

function chop:update()
    print("update chop...")
    if self.chop_target == nil then
        table.insert(self.parent.villager.tasks,
                     g.tasks.find("tree",self.parent,
                                  {["class"]=self,["function"]=self.set_target} 
                                    ))
    else
        local wood = self.chop_target.tree:chop()
        --tree is done
        if wood == 0 then
            self.parent.villager.village:add_resource("wood", self.wood)
            return true
        end
        self.wood = self.wood + wood
    end
end

function chop:set_target(target)
    self.chop_target = target
end



return chop