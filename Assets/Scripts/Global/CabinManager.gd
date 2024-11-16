extends Node

var temp:float=65
var roof:float=1
var outside_temp:float=60

var fire_fuel:float=20
var fire_temp:float=65

var odors = [null,null,null]
var cooking:bool=false

var player_chest:Array[Item]=[]
var sibling_chest:Array[Item]=[]

func _ready():
	Clock.ten_minutes.connect(ten_minutes)

func ten_minutes():
	if fire_fuel>0:	change_fire(-0.5)
	if Clock.hour>6 and !Clock.am:
		outside_temp-=0.5
	if Clock.hour>6 and Clock.am:
		outside_temp+=0.5
	update_temp()
	
func update_temp():
	var insulation = roof*(outside_temp-temp)
	var heat_output=fire_fuel/20
	temp+=insulation*0.1
	temp+=heat_output
	
func change_fire(num:float):
	fire_fuel+=num
