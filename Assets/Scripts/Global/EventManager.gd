extends Node

enum interval{Minute,Hour}

var minute_events = {}
var hour_events = {}
var daily_events

func _ready():
	Clock.ten_minutes.connect(ten_minutes)
	Clock.one_hour.connect(per_hour)
	
func create_event(e:EventObject,i:interval,t:int):
	if i==interval.Minute:
		minute_events[e]=t
	else:
		hour_events[e]=t
	
func ten_minutes():
	for x in minute_events:
		x.update()
		minute_events[x]-=1
		if minute_events[x]<=0:
			x.end_event()
			minute_events.erase(x)
			
	for x in [PlayerManager.data, SisterManager.sibling]:
		x.change_hunger(-1)
		if x.hunger<10:
				x.change_happiness(-1)
				x.change_energy(-1)
				x.change_will(-1)
				x.change_strength(-1)	
		if x.energy<x.max_energy*.1:
			x.change_will(-1)
			x.change_strength(-1)
		if x.nausea: x.change_energy(-5)
		MainMenu.set_bars()

func per_hour():
	
	for x in hour_events:
		x.update()
		hour_events[x]-=1
		if hour_events[x]<=0:
			x.end_event()
			hour_events.erase(x)
	
	for x in [PlayerManager.data, SisterManager.sibling]:
		x.change_protein(-1)
		x.change_nutrients(-1)
		x.change_energy(-1)
		if x.protein<10 or x.nutrients<10:
			x.malnutrition=true
			x.days_malnutrition+=1/24
		if x.protein>10 and x.nutrients>10:
			x.malnutrition=false
			x.days_malnutrition=0
		if x.days_malnutrition>4:
			x.change_energy(-10)
