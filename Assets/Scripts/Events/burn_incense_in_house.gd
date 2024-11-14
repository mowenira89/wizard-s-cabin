class_name BurnIncenseInHouse extends EventObject

var incense:String

func set_incense(i:String):
	incense=i
	list=CabinManager.odors

func start_event():
	CabinManager.odors.pop_at(0)
	CabinManager.odors.append(self)
