class_name Notification extends Panel
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	timer.start(10)

func set_note(s:String):
	label.text=s

func _on_timer_timeout() -> void:
	anim.play('fade')
	



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=='fade':
		queue_free()
