local pos = class_base:extend()

function pos:new(x,y)
    self.x = x
    self.y = y
end



return {pos=pos}