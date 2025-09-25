local campfire = class_base:extend()

local P_SIZE = 5

function campfire:new(pos)
  self.pos = pos
  self.burn_time = 100
  self.state = "building"
end

function campfire:draw()
  if self.state == "building" then
    gr.line(self.pos.x*5, self.pos.y*5,
            self.pos.x*5 + P_SIZE,self.pos.y*5 + P_SIZE)
    gr.line(self.pos.x * 5 + P_SIZE , self.pos.y * 5,
      self.pos.x * 5, self.pos.y * 5 + P_SIZE)
  elseif self.state == "done" then
    gr.push()
    --fire
    gr.setColor(255,255,0)
    gr.rectangle("fill",self.pos.x*5,self.pos.y*5,5,5)
    
    --wood
    gr.pop()
  elseif self.state == "ruined" then
  end

end


function campfire:finish()
  self.state = "done"
end

function campfire:update()
  self.burn_time = self.burn_time -1
end

function campfire:destroy()
  self.state = "ruined"
end

return campfire
