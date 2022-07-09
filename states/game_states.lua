
--kind of a enum class because it has no object but has variables ?
GameStates =class_base:extend()

--state definitions
GameStates.MAIN_MENUE       = 1
GameStates.PLAYING          = 2
GameStates.PAUSED           = 3
GameStates.GAME_SELECT      = 4
GameStates.SCORE            = 5
GameStates.REGISTER_PLAYERS = 6 --to register players at the startup


GameStates._base_state = require(g._(...).."state_sample")
GameStates.sim_run = require(g._(...).."simulation_run").init(GameStates._base_state)




