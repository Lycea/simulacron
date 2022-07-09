local entity = class_base:extend()



function entity:new(info)
    self.pos = g.lib.base_type.pos(info.pos.x, info.pos.y)
    self.size =g.lib.base_type.pos(5,5)

    self.state = g.lib.entity_states.idle(self)
    self.state:on_enter()
end


function entity:update()
    self.state:update()
end


function entity:draw()
    love.graphics.rectangle("line",self.pos.x* self.size.x  ,self.pos.y* self.size.y,
                              self.size.x ,self.size.y)
end

return entity