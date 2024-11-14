class_name NormalState extends State

@onready var menu: MenuState = $"../Menu"


func init():
	pass
	
func enter():
	PlayerManager.player.can_move=true
	
func exit():
	PlayerManager.player.can_move=false
	
func process(delta)->State:
	return null
	
func physics(delta)->State:
	return null

func handle_input(event)->State:
	if event.is_action_pressed('x'):
		return menu
	return null
