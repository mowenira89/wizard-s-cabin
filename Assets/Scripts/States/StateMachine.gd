class_name StateMachine extends Node

var states=[]
var prev_state:State
var current_state:State
var entity:CharacterBody2D=null

@onready var woodchopping: Woodchopping = $Woodchopping
@onready var normal:NormalState = $Normal

func _ready():
	process_mode=Node.PROCESS_MODE_DISABLED
	
func initialize():	
	for c in get_children():
		if c is State: states.append(c)
	if states.size()>0:
		for x in states:
			x.state_machine=self
			x.entity = entity
			x.init()
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta):
	change_state(current_state.process(delta))
	
func _physics_process(delta):
	change_state(current_state.physics(delta))
	
func _unhandled_input(event):
	change_state(current_state.handle_input(event))
	
func change_state(new_state:State):
	if new_state==null or new_state==current_state:return
	if current_state: current_state.exit()
	prev_state=current_state
	current_state=new_state
	current_state.enter()


func switch_state(s:String):
	match s:
		"woodchopping":change_state(woodchopping)
		"normal":change_state(normal)
