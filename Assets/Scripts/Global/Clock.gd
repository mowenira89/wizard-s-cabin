class_name C extends Node
@onready var timer: Timer = $Timer

signal ten_minutes
signal one_hour
signal day_passed

var day=1
var hour:int=6
var min:int=0
var am:bool=true



func _ready():
	timer.start(10)


func _on_timer_timeout() -> void:
	min+=1
	ten_minutes.emit()
	if min==7:
		min=0
		hour+=1
		one_hour.emit()
		if hour==12 and am: day+=1
		if hour==13:
			hour=1
			am=!am
