extends Node

var minute_events = {}
var hour_events = {}

var per_minute_event = {}
var per_hour_event = {}

func _ready():
	Clock.ten_minutes.connect(ten_minutes)
	Clock.one_hour.connect(per_hour)
	
func ten_minutes():
	for x in [PlayerManager.data, SisterManager.sibling]:
		x.change_hunger(-1)
		if x.hunger<10:
				x.change_happiness(-1)
				x.change_energy(-1)
				x.change_will(-1)
				x.change_strength(-1)	
		x.change_energy(-1)
		if x.energy<x.max_energy*.1:
			x.change_will(-1)
			x.change_strength(-1)
		MainMenu.set_bars()

func per_hour():
	for x in [PlayerManager.data, SisterManager.sibling]:
		x.change_protein(-1)
		x.change_nutrients(-1)
		if x.protein<10 or x.nutrients<10:
			x.malnutrition=true
			x.days_malnutrition+=1/24
		if x.protein>10 and x.nutrients>10:
			x.malnutrition=false
			x.days_malnutrition=0
		if x.days_malnutrition>4:
			x.change_energy(-10)
