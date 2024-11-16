class_name NormalState extends State

@onready var menu: MenuState = $"../Menu"


func init():
	pass
	
func enter():
	PlayerManager.player.can_move=true
	MainMenu.enable_hotbar()
	
func exit():
	PlayerManager.player.can_move=false
	MainMenu.disable_hotbar()
	
func process(delta)->State:
	return null
	
func physics(delta)->State:
	return null

func handle_input(event)->State:
	if event.is_action_pressed('x'):
		return menu
	if event.is_action_pressed('MWU'):
		MainMenu.change_equipped(-1)
	if event.is_action_pressed('MWD'):
		MainMenu.change_equipped(1)
	return null
