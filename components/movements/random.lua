local random = class_base:extend()

function random:new(parent)
    self.parent = parent
end

function random:update()
    if love.math.random(0,1) > 0.5 then
        self.parent.pos.x = self.parent.pos.x +1
        if self.parent.pos.x > scr_w /5 then  self.parent.pos.x = 0 end
        
    else
        self.parent.pos.y = self.parent.pos.y +1
        if self.parent.pos.y > scr_h /5 then  self.parent.pos.y = 0 end
    end

end
return random