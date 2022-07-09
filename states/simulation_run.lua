

function init(base)

    local sim_run = base:extend()

    function sim_run:new()

    end

    function sim_run:update()
        for _,entity in pairs(g.var.entitys) do
            entity:update()
        end
    end

    function sim_run:draw()
        for _,entity in pairs(g.var.entitys) do
            entity:draw()
        end
    end

    return sim_run

end

return {init=init}