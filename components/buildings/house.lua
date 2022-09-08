local house = class_base:extend()

function house:new(pos,parent)
    self.pos = pos
    self.parent = parent

    self.state = "building"
    self.parent.population_in_progress = self.parent.population_in_progress +5
end

function house:draw()
    if self.state == "building" then

        love.graphics.line(self.pos.x*5,self.pos.y*5 ,self.pos.x*5,self.pos.y*5+5) -- |
        love.graphics.line(self.pos.x*5,self.pos.y*5 ,self.pos.x*5 + 5 ,self.pos.y*5)--  -
        love.graphics.line(self.pos.x*5 + 5,self.pos.y*5 ,self.pos.x*5 + 5 ,self.pos.y*5 + 5)-- |

    elseif self.state == "done" then
        love.graphics.rectangle("line",self.pos.x*5,self.pos.y*5,5,5)

        love.graphics.line(self.pos.x*5 ,self.pos.y*5 ,
                           self.pos.x*5 +3 ,self.pos.y*5 - 3) -- /
                           
        love.graphics.line(self.pos.x*5 +5 ,self.pos.y*5 ,
                           self.pos.x*5 +3 ,self.pos.y*5 - 3)


    elseif self.state == "ruined" then

    end
end

function house:finish()
    self.parent.population_cap = self.parent.population_cap + 5
    self.state = "done"
    self.parent.population_in_progress = self.parent.population_in_progress -5
end

function house:destroy()
    self.state = "ruined" 
    self.parent.population_cap = self.parent.population_cap - 5
end

return house