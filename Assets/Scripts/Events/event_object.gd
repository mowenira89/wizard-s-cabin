class_name EventObject extends Resource

enum types {ForMinutes,ForHours,AfterMinutes,AfterHours,OfferingTrigger}

enum intervals {Minute,Hour,Daily}
var id
var type
var turns
var interval
var list

func set_event(id:float,interval:intervals,turns:int):
	id=id
	interval=interval
	turns=turns
	match interval:
		intervals.Minute: Clock.one_minute.connect(update_event)
		intervals.Hour: Clock.one_hour.connect(update_event)

func update_event():
	pass
	
func start_event():
	pass

func end_event():
	pass
