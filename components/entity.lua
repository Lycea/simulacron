local entity = class_base:extend()



function entity:new(info)
    self.pos = g.lib.base_type.pos(info.pos.x, info.pos.y)
    self.size =g.lib.base_type.pos(5,5)
    print("state",info.state)
    self.state = g.lib.entity_states[info.state or "idle"](self)
    self.state:on_enter()
    self.tags ={}
    if info.tags ~= nil then
        for _, tag_name  in pairs(info.tags) do
            self.tags[tag_name]=true
        end
    end    
end

function entity:add_component(name, value)
    self[name] = value
end

function entity:update()
    self.state:update()
end


function entity:draw()
    love.graphics.rectangle("fill",self.pos.x* self.size.x  ,self.pos.y* self.size.y,
                              self.size.x ,self.size.y)
    
end

return entity