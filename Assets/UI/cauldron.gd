class_name Cauldron extends StaticBody2D

@onready var ingredient_1: TextureButton = $ingredient1
@onready var ingredient_2: TextureButton = $ingredient2
@onready var cook_button: Button = $CookButton
@onready var output_balloon: IngredientBalloon = $ingredient3


func _ready():
	set_ingredients()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		var e = MainMenu.equipped.item
		if e!=null:
			if ItemData.kywrds.Ingredient in e.data.keywords:
				add_ingredient(e)
			
func set_ingredients():
	if CookingManager.ingredient1!=null:
		ingredient_1.set_ingredient(CookingManager.ingredient1)
	if CookingManager.ingredient2!=null:
		ingredient_2.set_ingredient(CookingManager.ingredient2)
	if CookingManager.ingredient1!=null or CookingManager.ingredient2!=null:
		cook_button.visible=true

func add_ingredient(i:Item):
	if CookingManager.ingredient2!=null:return false
	if CookingManager.ingredient1!=null:
		CookingManager.ingredient2=i
		ingredient_1.set_ingredient(i)
		InvManager.remove_item(MainMenu.equipped_index,1,MainMenu.equipped.inventory)
		return true
	else:
		CookingManager.ingredient1=i
		ingredient_1.set_ingredient(i)
		InvManager.remove_item(MainMenu.equipped_index,1,MainMenu.equipped.inventory)
		cook_button.visible=true
		return true

func hide_cook():
	cook_button.visible=false


func _on_cook_button_pressed() -> void:
	var meal = CookingManager.cook()
	output_balloon.set_ingredient(meal)
