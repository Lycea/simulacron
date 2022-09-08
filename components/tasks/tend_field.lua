local tend_field = class_base:extend()


function tend_field:new(parent, field, field_id)
    self.parent = parent

    self.field = field
    self.field_id = field_id
    self.goal  = field.pos
    -- print("    setting mover goal")
    self.parent.mover:set_goal(self.goal)

    self.harvest_timer = 5
    self.sew_timer     = 5
end


function tend_field:update()

    if self.parent.mover:done() then
        -- print("    done moving to plot")

        if self.harvest_timer > 0 then
            -- print("    harvesting...")
            self.harvest_timer = self.harvest_timer -1
            return
        end

        if self.sew_timer >0 then
            -- print("    sewing...")
            self.sew_timer = self.sew_timer - 1
            return
        end

        -- print("-----------------------")
        -- print("resetting field states")
        -- print("Own field state")
        -- print("  state:",self.field.status)
        self.field.state = 1
        self.field.timer  = 0
        self.parent.villager.village.mill.grow_cnt = self.parent.villager.village.mill.grow_cnt -1
        self.parent.villager.village.mill.grown_plots[self.field_id] = nil
        return true
    end
end


return tend_field
