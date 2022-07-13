require("key_handle")
require("renderer.renderer")

g = require("globals")

require("states.game_states")
sample_state=require("states.state_sample")


local game ={} 


--------------------------- 
--preinit functions? 
--------------------------- 
 
 
local base={} 
------------------------------------------------------------ 
--Base data fields 
------------------------------------------------------------ 
 

constants = nil


------------------------ 
-- dynamic data 



--game state
game_state = GameStates.MAIN_MENUE
previous_game_state = game_state



--others
key_timer = 0--timer between movement



mouse_coords={0,0}


exit_timer =0
selector_timer = 0
target_timer   = 0

show_main_menue =true
main_menue_item = 1

selected_state_idx = 1

run_state = nil

update_timer = g.lib.timer(0.000000001)
draw_timer   = g.lib.timer(0.1)
----------------------------------------------------------- 
-- special data fields for debugging / testing only 
----------------------------------------------------------- 



function update_menue()
	for key,v in pairs(key_list) do
      print("Key pressed",key)
    local action=handle_main_menue(key)--get key callbacks
        if action["menue_idx_change"] ~= nil then
          if key_timer+0.2 < love.timer.getTime() then
            
            main_menue_item = main_menue_item+ action["menue_idx_change"][2] 
            if main_menue_item <1 then main_menue_item = 1 end
            if main_menue_item>4 then main_menue_item = 4 end
            print(main_menue_item)
          
            key_timer = love.timer.getTime()
          
          end
          
        end
        
        -- main menu action handling
        if action["selected_item"]~= nil then
          show_main_menue = false
          --menue item switcher
          if main_menue_item == 1 then--new game
            game_state=GameStates.PLAYING
            game.new()
          elseif main_menue_item == 2 then--load game
            
            
          elseif main_menue_item == 3 then
            
          else
            love.event.quit()
          end
          
          
        end
        
        if action["exit"]~= nil then
            love.event.quit()
        end
	end
end



--loading a game
function game.load() 
  run_state = GameStates.sim_run()

end 
 
 
 --new game
function game.new()
  run_state:startup()
end

 

function game.play(dt) 

    

  
 if update_timer:check() then
  run_state:update()
 end

  
  
  -- Enemy behaviour basic / Enemy turn
  

end 
 
 
--main loop
function game.update(dt) 
  
  --handle game stuff
    game.play(dt)

  
    
end

 
function game.draw() 

  run_state:draw()
end 
 
 
 
 
--default key list to check


function game.keyHandle(key,s,r,pressed_) 
  if pressed_ == true then
    key_list[key] = true
    last_key=key
  else
    key_list[key] = nil
  end
end 
 
 


function game.MouseHandle(x,y,btn) 
   mouse_click={x=x,y=y,btn=btn}

  if btn == 1 then
    table.insert(g.var.entitys,g.lib.entity( 
                    {
                      pos = {
                              x=math.floor(x/5),
                              y=math.floor(y/5) },
                      state = "do_tasks",
                      color = {255,255,255}
                    }  ))
  elseif btn == 2 then
    local tmp_entity = g.lib.entity( 
      {
        pos = {
                x=math.floor(x/5),
                y=math.floor(y/5) },
        state = "_base_state",
        tags ={"tree"},
        color = {0,255,0}
      }  )
    tmp_entity:add_active_callback("tree", "check")
    tmp_entity:add_component("tree", g.lib.tree())
    table.insert(g.var.entitys,tmp_entity)
  end
end 
 
function game.MouseMoved(mx,my) 
  mouse_coords={mx,my}
end 
 
 

return game