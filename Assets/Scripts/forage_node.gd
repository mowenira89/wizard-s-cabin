extends Marker2D

const pickup = preload("res://Assets/Scenes/pickup.tscn")
var time_to_next:int
var pickup_ref:Pickup=null

func _ready():
	if self not in ForageManager.nodes: 
		ForageManager.nodes[self]=pickup_ref
	if pickup_ref==null:
		get_loot()

func get_loot():
	var item_type = ForageManager.get_loot()
	var i = Item.new()
	i.set_item(item_type, 1)
	var p = pickup.instantiate()
	add_child(p)
	p.set_item(i)
	p.forage_node=self
	p.global_position=global_position
	pickup_ref=p
	ForageManager.nodes[self]=pickup_ref
	Signals.pickup_picked_up.connect(pickup_picked)

func pickup_picked(i:Pickup):
	if i==pickup_ref: set_timer()
	Signals.pickup_picked_up.disconnect(pickup_picked)
	
func set_timer():
	pickup_ref=null
	time_to_next=randi_range(50,500)
	Clock.ten_minutes.connect(reduce_time)
	
func reduce_time():
		time_to_next-=randi_range(1,11)
		if time_to_next<=0:
			get_loot()
			Clock.ten_minutes.disconnect(reduce_time)
