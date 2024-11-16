class_name Woodchopping extends State

const woodchopper = preload("res://Assets/Scenes/woodchopper.tscn")
var wc_ref:Woodchopper=null


func enter():
	var wc = woodchopper.instantiate()
	wc_ref=wc
	PlayerManager.player.add_child(wc)
	wc.global_position=PlayerManager.player.global_position+Vector2(20,-20)
	
func exit():
	wc_ref.queue_free()
	
func handle_input(event:InputEvent):
	if event.is_action_pressed('f'):
		if wc_ref.in_range:
			chop_wood()
	if event.is_action_pressed('x'):
		GameStateMachine.switch_state("normal")
		

func chop_wood():
	var wood = Item.new()
	wood.set_item('wood',1)
	InvManager.add_inv_item(wood,InvManager.inventory)
	PlayerManager.data.change_energy(-2)
	wc_ref.move_target()
