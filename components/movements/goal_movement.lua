local goal_based = class_base:extend()

function goal_based:new(parent)
    self.parent = parent

    self.goal = nil
    self.start =  nil
end



function goal_based:set_goal(pos)
    self.__done = false
    --print("Setting goal to",pos.x,pos.y)
    --print("pos",self.parent.pos.x,self.parent.pos.y)
    self.goal = pos
    self.start = self.parent.pos:copy()
end

function goal_based:done()
    return self.__done
end

function goal_based:is_same(pos_a,pos_b)
    --print("check")
    return pos_a.x == pos_b.x and pos_a.y == pos_b.y
end




local function sample_movement()

end

function goal_based:move(x,y)
    self.parent.pos = g.lib.base_type.pos(x, y)
   -- print("current pos",x,y,"goal",self.goal.x,self.goal.y)
end

function goal_based:move_8()
    
    local dx = self.goal.x - self.parent.pos.x
    local dy = self.goal.y - self.parent.pos.y
    
    local distance = math.sqrt(dx^2+dy^2)
    
    dx =math.floor(dx/distance +0.5) --+ self.parent.pos.x
    dy =math.floor(dy/distance +0.5) --+ self.parent.pos.y


    --if  gvar.map:is_blocked(self.x+dx,self.y+dy)==false and
    
    self:move(dx+ self.parent.pos.x, dy+ self.parent.pos.y)
    --end
end




function goal_based:update()

    if self.goal == nil then


        --if love.math.random(0,1) > 0.5 then
        --    self.parent.pos.x = self.parent.pos.x +1
        --   if self.parent.pos.x > scr_w /5 then  self.parent.pos.x = 0 end
        --    
        --else
        --    self.parent.pos.y = self.parent.pos.y +1
        --    if self.parent.pos.y > scr_h /5 then  self.parent.pos.y = 0 end
        --end
    else
        if self.__done == true then

            return
        end
        if self:is_same(self.goal,self.parent.pos) == false then
            --self.start =g.lib.helpers.lerp_2d(self.start,self.goal,0.1)
            --self.parent.pos = self.start
            self:move_8()
        else
            self.__done =true

            print("goal reached", 
            self.goal.x.." "..self.goal.y,"|",
            self.parent.pos.x.." "..self.parent.pos.y)
        end
    end

end
return goal_based