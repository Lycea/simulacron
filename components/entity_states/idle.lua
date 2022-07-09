


function init(base)
    local idle = base:extend()
    function idle:new(parent)
        self.parent = parent    
    end

    function idle:on_enter()
        self.parent.mover = g.lib.movements.random(self.parent)
    end
    function idle:on_exit()

    end
    function idle:update()
        self.parent.mover:update()
    end

    return idle
end


return {init=init}