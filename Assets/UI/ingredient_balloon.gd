class_name IngredientBalloon extends TextureButton
@onready var icon: TextureRect = $i1Icon

var item:Item
@export var ingred_num:int

func set_ingredient(i:Item):
	item=i
	icon.texture = load("res://Assets/Art/Items/"+i.data_name+".png")
	visible=true

func _on_pressed() -> void:
	if InvManager.add_inv_item(item, InvManager.inventory):
		match ingred_num:
			1: CookingManager.ingredient1=null
			2: CookingManager.ingredient2=null
		visible=false
		if CookingManager.ingredient1==null and CookingManager.ingredient2==null:
			get_parent().hide_cook()
