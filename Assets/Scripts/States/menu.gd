class_name MenuState extends State

@onready var normal: NormalState = $"../Normal"


func init():
	pass
	
func enter():
	PlayerManager.player.can_move=false
	MainMenu.open_main_menu()
	MainMenu.disable_hotbar()
	
func exit():
	pass
	
func process(delta)->State:
	return null
	
func physics(delta)->State:
	return null

func handle_input(event:InputEvent)->State:
	if event.is_action_pressed("x"):
		return close_menu()
	if event.is_action_pressed('esc'):
		print('esc')
		return close_menu()
			 
	return null

func close_menu():
	MainMenu.close_main_menu()
	return normal
