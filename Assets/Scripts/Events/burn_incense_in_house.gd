class_name BurnIncenseInHouse extends EventObject

var incense:String

func set_incense(i:String):
	incense=i
	list=CabinManager.odors

func start_event():
	CabinManager.odors.pop_at(0)
	CabinManager.odors.append(self)
	
func end_event():
	var x = CabinManager.odors.find(self)
	CabinManager.odors.erase(x)
