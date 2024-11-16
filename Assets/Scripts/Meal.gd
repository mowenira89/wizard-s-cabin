class_name Meal extends Item

var ingredients:Array[String]

func set_ingredients(i:Array[String]):
	ingredients=i

func use(target:Entity=null):
	target.eat(self)
