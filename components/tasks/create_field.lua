-- how to:
-- get next plot
-- move to plot
-- create plot

local create_field = class_base:extend()

function create_field:new(parent)
    self.parent = parent
    self.goal = nil

    self._creation_time = 5
end

function create_field:update()
    if self.goal == nil then
        self.goal = self.parent.villager.village.mill:get_next_plot_pos()
        self.parent.mover:set_goal(self.goal)
    end

    if self.parent.mover:done() then
        if self._creation_time >0 then
            self._creation_time = self._creation_time - 1
        else
            self.parent.villager.village.mill:add_plot()
            return true
        end
    end
end

return create_field