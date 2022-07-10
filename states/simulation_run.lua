

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

        for _, village in pairs(g.var.villages) do
            for _,building in pairs(village.buildings) do
                building:draw()
            end
        end
    end

    return sim_run

end

return {init=init}