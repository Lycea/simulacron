

function init(base)

    local sim_run = base:extend()

    function sim_run:new()
       --g.lib.ui:init()
    end 

    function sim_run:update()
        for _,entity in pairs(g.var.entitys) do
            entity:update()
        end

        for _,village in pairs(g.var.villages) do
            village:update()
        end

        --g.lib.ui:update()
    end

    function sim_run:draw()
        love.graphics.push()
        love.graphics.setBackgroundColor(17,130,0)
        --love.graphics.rectangle("fill",0,0,scr_w,scr_h)
        love.graphics.pop()
        for _,entity in pairs(g.var.entitys) do
            entity:draw()
        end

        for _, village in pairs(g.var.villages) do
            for _,building in pairs(village.buildings) do
                building:draw()
            end
        end
        
        --g.lib.ui:draw()
    end

    return sim_run

end

return {init=init}
