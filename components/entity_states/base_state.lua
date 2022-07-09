local base_state = class_base:extend()


function base_state:new(parent_object)
    self.parent = parent_object
end

function base_state:update()
    
end

function base_state:on_enter()
    print("entering x/y")
end

function base_state:on_exit()
    print("exiting x/y")
end
return base_state