class_name Item extends Resource

var data_name:String
var data:ItemData
var quantity:int
var inventory:Array[Item]

func set_item(dname:String, q:int):
	data_name=dname
	quantity = q
	data = load("res://Assets/Resources/Items/"+dname+".tres")

func use(target:Entity):
	pass
