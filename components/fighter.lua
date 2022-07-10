local fighter = class_base:extend()

function fighter:new(hp,def,dmg)
    self.hp  = hp 
    self.def = def
    self.dmg = dmg
end


return fighter