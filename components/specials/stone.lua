local stone = class_base:extend()


function stone:new()
    self.max_stone = 50
    self.respawn_time = 10
    self.actual_stone = self.max_stone
    self.pick_amount = 5
    self.timer = g.lib.timer(self.respawn_time)
end

function stone:check()
  if self.actual_stone == 0 then
    if self.timer:check() then
      self.actual_stone = self.max_stone
      return true
    end
    return false
  else
    return true
  end
  
end


function stone:pick()
    local amount = 0

    --print(amount)
    --print(self.max_wood)
    --print(self)
    --print(self.actual_wood)
    --print("refs...")
    --for obj_name,value in pairs(self) do
    --    print(obj_name,value)
    --end

    if self.actual_stone  > 0  then
        if self.actual_stone >= self.pick_amount then
            amount = self.pick_amount
        else
            amount = self.actual_stone
            self.timer = g.lib.timer(self.respawn_time)
        end
    end

    self.actual_stone = self.actual_stone -amount
    return amount
end

return stone
