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

update_timer = g.lib.timer(0.1/2)
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
          -- Wmenue item switcher
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

function spawn_entity(id, name, active)
  if active == false then
    print("btn infos ", id, name, active)
    return
  end

  g.var.selected_placement_type = g.var.id_to_type_list[id]

  print("INFO spawn changed to... " .. g.var.selected_placement_type)
end

spawners_ = {}
function spawners_.tree(x, y)
  local tmp_entity = g.lib.entity(
    {
      pos = {
        x = math.floor(x / 5),
        y = math.floor(y / 5)
      },
      state = "_base_state",
      tags = { "tree" },
      color = { 0, 255, 0 }
    })
  tmp_entity:add_active_callback("tree", "check")
  tmp_entity:add_component("tree", g.lib.tree())
  table.insert(g.var.entitys, tmp_entity)
end

function spawners_.stone(x, y)
  local tmp_entity = g.lib.entity(
    {
      pos = {
        x = math.floor(x / 5),
        y = math.floor(y / 5)
      },
      state = "_base_state",
      tags = { "stone" },
      color = { 150, 150, 150 }
    })
  tmp_entity:add_active_callback("stone", "check")
  tmp_entity:add_component("stone", g.lib.stone())
  table.insert(g.var.entitys, tmp_entity)
end

function spawners_.people(x, y)
  table.insert(g.var.entitys, g.lib.entity(
    {
      pos = {
        x = math.floor(x / 5),
        y = math.floor(y / 5)
      },
      state = "do_tasks",
      color = { 255, 255, 255 }
    }))
end

--- @param name string
--- @param ui_parent Window | Vertical | Horizontal | SimpleUI
--- @param callback function
function add_entity_selection(name, ui_parent, callback)
  btn_ = ui_parent:AddToggleButton(name, 0, 0, 0, 0)
  print("---------------------------")
  print("adding button id: " .. btn_)
  ui_parent:SetSpecialCallback(btn_, callback)
  g.var.id_to_type_list[btn_] = name

  return btn_
end


function setup_ui()
  local ui_infos = g.var.ui
  local g_ui = g.lib.ui
  print("ui placement",scr_h,scr_w)
  g_ui:set_pre_11_colors(true)
  
  
  ui_infos.selection_window = g_ui:GetObject( g_ui:add_window(0, (scr_h / 3) * 2, scr_w, scr_h / 3)) ---@type Window
  ui_infos.selection_window:set_layout("horizontal")
  ui_infos.selection_window.options.has_background = true

  
  ui_infos.item_layouts = {}
  ui_infos.item_layouts.l1 = ui_infos.selection_window:GetObject(ui_infos.selection_window:AddVlayout(0, 0, 0, 0))
  ui_infos.item_layouts.l2 = ui_infos.selection_window:AddVlayout(0, 0, 0, 0)
  ui_infos.item_layouts.l3 = ui_infos.selection_window:AddVlayout(0, 0, 0, 0)

  -- ui_infos.item_layouts.l1:AddToggleButton("tree", 0, 0, 0, 0)
  -- ui_infos.item_layouts.l1:AddToggleButton("stone", 0, 0, 0, 0)
  --   ui_infos.item_layouts.l1:AddToggleButton("person", 0, 0, 0, 0)


  layouts = ui_infos.item_layouts

  ui_infos.__toggle_group = {
    add_entity_selection("tree", layouts.l1, spawn_entity),
    add_entity_selection("stone", layouts.l1, spawn_entity),
    add_entity_selection("people", layouts.l1, spawn_entity)
  }

  layouts.l1:GetObject( ui_infos.__toggle_group[1]):toggle(true)

  ui_infos.item_layouts.l1:AddOptionGroup(ui_infos.__toggle_group, "spawn_toggles_1")

  ui_infos.selection_window:enable_titlebar(false)
  ui_infos.selection_window:redraw()
end

--loading a game
function game.load()
  print("----\n game load")
  run_state = GameStates.sim_run()
  setup_ui()
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
    g.lib.ui:update(dt)
end

 
function game.draw() 
    run_state:draw()
    g.lib.ui:draw()
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


function game.MouseHandle(x, y, btn)

  if g.var.ui.selection_window:in_area(g.var.ui.selection_window.rect_area,{x=x,y=y}) then
    print("ignore spawn click ...")
    return
  end

  if g.var.valid_types[  g.var.selected_placement_type] == true  then
        spawners_[g.var.selected_placement_type](x, y)
  else
    print("not allowed !!!!")
  end
end 
 
function game.MouseMoved(mx,my) 
  mouse_coords={mx,my}
end 
 
 

return game
