


function init(base)
    local idle = base:extend()
    function idle:new(parent)
        self.parent = parent    
    end

    function idle:on_enter()
        self.parent.mover = g.lib.movements.goal_movement(self.parent)

        local x_g = love.math.random(0, scr_w/5)
        local y_g = love.math.random(0, scr_h/5)
        self.parent.mover:set_goal( g.lib.base_type.pos(x_g, y_g))
    end
    function idle:on_exit()

    end
    function idle:update()
        self.parent.mover:update()
        
        if self.parent.mover:done() then
            local x_g = love.math.random(0, scr_w/5)
            local y_g = love.math.random(0, scr_h/5)
            self.parent.mover:set_goal( g.lib.base_type.pos(x_g, y_g) )
        end
    end

    return idle
end


return {init=init}