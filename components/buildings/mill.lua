local mill = class_base:extend()



local plot = class_base:extend()

local P_SIZE = 5
function plot:new(pos)
    self.pos = pos
    self.state = 1

    self.state_timer = 100
    self.time = 0

    self.state_order = {"fresh", "growing", "done"}
end

function plot:update()
    self.time = self.time +1
    if self.time >= self.state_timer and self.state~= #self.state_order then
        self.time = 0
        self.state = self.state+1
        if self.state == #self.state_order then
            return true
        end
    end

end

function plot:draw()
    if self.state == 1 then

        love.graphics.rectangle("line", self.pos.x*5, self.pos.y*5, P_SIZE, P_SIZE)
    elseif self.state ==2 then
        love.graphics.rectangle("fill", self.pos.x*5, self.pos.y*5, P_SIZE, P_SIZE)
    else
        love.graphics.setColor(70,255,70)
        love.graphics.rectangle("fill", self.pos.x*5, self.pos.y*5, P_SIZE, P_SIZE)
        love.graphics.setColor(255,255,255)
    end
end



function mill:new(pos,parent)
    self.pos = pos
    self.parent = parent
    self.plots = {}

    self.max_plots = 5*4

    self.state = "building"
    self.grown_plots = {}
    self.grow_cnt = 0
end

function mill:draw()
    if self.state == "building" then

        love.graphics.line(self.pos.x*5,self.pos.y*5 ,self.pos.x*5,self.pos.y*5+5) -- |
        love.graphics.line(self.pos.x*5,self.pos.y*5 ,self.pos.x*5 + 5 ,self.pos.y*5)--  -
        love.graphics.line(self.pos.x*5 + 5,self.pos.y*5 ,self.pos.x*5 + 5 ,self.pos.y*5 + 5)-- |

    elseif self.state == "done" then
        --base
        love.graphics.rectangle("line",self.pos.x*5,self.pos.y*5,5,5)
        
        middle_point = g.lib.base_types.pos(self.pos.x*5 +3 ,self.pos.y*5 - 3)

        --triangle top
        love.graphics.line(self.pos.x*5, self.pos.y*5,
                           middle_point.x, middle_point.y) -- /

        love.graphics.line(self.pos.x*5 +5 ,self.pos.y*5 ,
                           middle_point.x, middle_point.y)

        --windmil thingies
        --left
        love.graphics.polygon("fill", middle_point.x, middle_point.y 
                                    , middle_point.x - 7, middle_point.y -2
                                    , middle_point.x - 7, middle_point.y +2
                                    , middle_point.x, middle_point.y)
        --right
        love.graphics.polygon("fill", middle_point.x, middle_point.y 
                                    , middle_point.x + 7, middle_point.y -2
                                    , middle_point.x + 7, middle_point.y +2
                                    , middle_point.x, middle_point.y)
        --down
        love.graphics.polygon("fill", middle_point.x, middle_point.y 
                                    , middle_point.x - 2, middle_point.y +7
                                    , middle_point.x + 2, middle_point.y +7
                                    , middle_point.x, middle_point.y)
        
        --up
        love.graphics.polygon("fill", middle_point.x, middle_point.y 
                                    , middle_point.x - 2, middle_point.y -7
                                    , middle_point.x + 2, middle_point.y -7
                                    , middle_point.x, middle_point.y)

        for _, plot in pairs(self.plots) do
            plot:draw()
        end
    elseif self.state == "ruined" then

    end
end

function mill:get_next_plot_pos()
    if #self.plots == 0 then
      return g.lib.base_types.pos(self.pos.x-2, self.pos.y + 1 )
    else
        last_pos = self.plots[#self.plots].pos 
        if #self.plots%5 == 0 then
            return g.lib.base_types.pos(last_pos.x -4, last_pos.y +1)
        else
            return g.lib.base_types.pos(last_pos.x +1, last_pos.y)
        end
    end
end


function mill:add_plot()
    table.insert( self.plots, plot(self:get_next_plot_pos()) )

    -- if #self.plots == 0 then
    --     table.insert(self.plots,
    --                  plot(g.lib.base_types.pos(self.pos.x-2, self.pos.y + 1 )))
    -- else
    --     last_pos = self.plots[#self.plots].pos 
    --     if #self.plots%5 == 0 then
    --         new_pos = g.lib.base_types.pos(last_pos.x -4, last_pos.y +1)
    --         table.insert(self.plots,plot(new_pos))
    --     else
    --         new_pos = g.lib.base_types.pos(last_pos.x +1, last_pos.y)
    --         table.insert(self.plots,plot(new_pos))
    --     end
    -- end
end

function mill:update()
    for _, plot in pairs(self.plots) do
        ret = plot:update()
        if ret then
            -- print("================")
            -- print("grew a plot")
            -- print("plot id:  ".._)
            self.grown_plots[_]=ret
            self.grow_cnt = self.grow_cnt+1
            -- print("count: ",self.grow_cnt)
            -- print("================")
        end
    end 

    --if #self.plots < self.max_plots then
    --    self:add_plot()     
    --end
end


function mill:finish()
    self.state = "done"
    self.parent.mill_in_progress = false
    self.parent.mill = self
end

function mill:destroy()
    self.state = "ruined" 
end

return mill