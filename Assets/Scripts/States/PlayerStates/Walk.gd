class_name Walk extends State

@onready var idle = $"../Idle"

func enter():
	entity.UpdateAnimation('walk')

func process(delta):
	if entity.direction==Vector2.ZERO:
		return idle
	
	entity.velocity = entity.direction * PlayerManager.movement_speed
	
	if entity.SetDirection():
		entity.UpdateAnimation("walk")
	
	return null
