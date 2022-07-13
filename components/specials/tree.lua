local tree = class_base:extend()


function tree:new()
    self.max_wood = 50
    self.respawn_time = 10
    self.actual_wood = self.max_wood
    self.chop_amount = 5
    self.timer = g.lib.timer(self.respawn_time)
end
function tree:check()
  if self.actual_wood == 0 then
    if self.timer:check() then
      self.actual_wood = self.max_wood
      return true
    end
    return false
  else
    return true
  end
  
end


function tree:chop()
    local amount = 0

    --print(amount)
    --print(self.max_wood)
    --print(self)
    --print(self.actual_wood)
    --print("refs...")
    --for obj_name,value in pairs(self) do
    --    print(obj_name,value)
    --end

    if self.actual_wood  > 0  then
        if self.actual_wood >= self.chop_amount then
            amount = self.chop_amount
        else
            amount = self.actual_wood
            self.timer = g.lib.timer(self.respawn_time)
        end
    end

    self.actual_wood = self.actual_wood -amount
    return amount
end

return tree