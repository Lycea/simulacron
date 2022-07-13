local find = class_base:extend()

function find:new(what,parent,on_finish)
    self.to_search = what
    self.parent = parent
    self.on_finish = on_finish

    self._found_obj = nil
end


local function filter_entitys(name)
    local search_results = {}
    for _,entity in pairs(g.var.entitys) do
        if entity.tags[name] == true and entity:is_active() then
            table.insert(search_results, _)
        end
    end
    
    return search_results
end


function find:update()
    --print("updating find....")
    if self.goal == nil then
        --print("sorting...")  
        -- TODO: add condition for when not 
        local sorted_results = filter_entitys(self.to_search)
        table.sort(sorted_results,
            function (a,b)
                --print(a,b)
                return g.var.entitys[a].pos:distance_to(self.parent.pos) < g.var.entitys[b].pos:distance_to(self.parent.pos)
            end  )

        if #sorted_results == 0 then
            --print("no results, searching for:",self.to_search)
            self.goal = nil
        else
            self._found_obj = g.var.entitys[ sorted_results[1] ]
            self.goal = g.var.entitys[ sorted_results[1] ].pos:copy()
        end
        self.parent.mover:set_goal(self.goal)
    end

    if self.parent.mover:done() then
        --print("mover done")
        self.on_finish["function"](self.on_finish["class"],  self._found_obj)
        return true
    end

    
end
return find