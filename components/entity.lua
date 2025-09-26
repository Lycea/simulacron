local entity = class_base:extend()



function entity:new(info)
    self.pos = g.lib.base_type.pos(info.pos.x, info.pos.y)
    self.size =g.lib.base_type.pos(5,5)
    print("state",info.state)
    self.state = g.lib.entity_states[info.state or "idle"](self)
    self.state:on_enter()
    self.tags ={}
    self.color = info.color or nil

    self.free_slots = 2

    self.active = info.active or true
    self.active_callbacks ={}
    
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
    if self.tree then
        local ret =self.tree:check()
        if ret == false then self.color={255,0,0}
        else self.color = {0,255,0} end
    end 
end


function entity:draw()
    local color = self.color or {255,255,255}
    
    love.graphics.setColor(color[1], color[2], color[3])
    love.graphics.rectangle("fill",self.pos.x* self.size.x  ,self.pos.y* self.size.y,
                              self.size.x ,self.size.y)

    love.graphics.setColor(255, 255, 255)

    -- gr.print("free: " .. self.free_slots,
             -- self.pos.x* self.size.x,(self.pos.y-5)*self.size.y)
end

function entity:is_free()
    local is_free = false

    if self.free_slots >0 then
      is_free = true
    end
  return is_free
end

function entity:is_active()
    local active = false
    local o=self
    for _,cb in pairs(self.active_callbacks) do
       if   self[cb.component][cb["function"]](self[cb.component]) then
         active = true
       end
    end
    
    
    self.active = active
    --print("active state tree:  ",self.active)
    return self.active
end

function entity:add_active_callback(component,call)
    print("adding callback for:",component,call)
    table.insert(self.active_callbacks, {component=component,["function"]=call})
end

return entity
