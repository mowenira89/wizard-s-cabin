extends Node

const meals = {
	['bread','cheese']:'grilled-cheese',
	['bread','fish']:'po-boy',
	['bread','fish','water']:'fish-gruel',
	['bread','fruit']:'bread-and-fruit',
	['carrot','flour']:'carrot-cake',
	['dandelion','water']:'dandelion-tea',
	['dandelion','honey']:'dandelion-candy',
	['chamomile','honey']:'lozenge',
	['chamomile','water']:'chamomile-tea',
	['cheese']:'fondue',
	['cheese','cheese']:'fondue',
	['cheese','fish']:'cheesy-roasted-fish',
	['cheese','fish','water']:'cheesy-fish-stew',
	['cheese','herb']:'hidden-medicine',
	['cheese','flour']:'cheese-bread',
	['cheese','vegetable']:'cheesy-veg',
	['fish']:'roasted-fish',
	['fish','water']:'fish-stew',
	['fish','herb']:'seasoned-roasted-fish',
	['fish','herb','water']:'seasoned-fish-stew',
	['fish','vegetable']:'roast-fish-veg',
	['flour']:'bread',
	['flour','flour']:'bread',
	['flour','fruit']:'fruit-pie',
	['flour','honey']:'cookies',
	['flour','herb']:'focaccia',
	['flour','poppy']:'poppy-seed-bagel',
	['flour','water']:'gruel',
	['flour','milk']:'buttermilk-biscuit',
	['fruit','herb']:'seaoned-fruit',
	['fruit','honey']:'sweetened-fruit',
	['fruit','vegetable']:'nutritious-mush',
	['herb','water']:'weak-herbal-tea',
	['herb','herb','water']:'herbal-tea',
	['herb','herb']:'oops-all-herbs',
	['honey','feverfew']:'fever-suppressant',
	['honey']:'honey',
	['honey','honey']:'big-bowl-honey',
	['honey','poppy']:'lozenge',
	['honey','milk']:'sweetened-milk',
	['fruit','honey','water']:'fruit-juice',
	['fish','honey']:'swedish-fish',
	['fish','honey','water']:'swedish-fish-stew',
	['poppy','water']:'poppy-tea',
	['poppy','poppy','water']:'strong-poppy-tea',
	['mushroom']:'grilled-mushroom',
	['mushroom','mushroom']:'grilled-mushroom',
	['milk','mushroom','water']:'cream-of-mushroom',
	['vegetable']:'roast-veg',
	['vegetable','vegetable']:'roast-veg',
	['vegetable','water']:'vegetable-soup',
	['vegetable','vegetable','water']:'vegetable-stew'

	
}

func get_meal(ingredients:Array[Item]):
	
	var meal=null
	var sorted_ingredients=[]
	for i in ingredients:
		sorted_ingredients.append(i.data_name)
	sorted_ingredients.sort()
	if sorted_ingredients in meals:
		meal = Meal.new()
		meal.set_ingredients(sorted_ingredients)
		var q = get_quantity(sorted_ingredients)
		meal.set_item(meals[sorted_ingredients], q)
		return meal
		
	var ingredient_ids=sorted_ingredients.map(get_id)
	ingredient_ids.sort()
	if ingredient_ids in meals:
		meal = Meal.new()
		meal.set_ingredients(sorted_ingredients)
		meal.set_item(meals[ingredient_ids])
		return meal
	
func get_quantity(i:Array[String]):
	if i in [['fish','fish'],['fish','fish','water'],['mushroom','mushroom'],['vegetable','vegetable']]:
		return 2
	return 1
	
	
func get_id(ingredient):
	if ingredient in ['poppy', 'dandelion', 'rosemary','thyme','chamomile','feverfew', 'sage']:
		return 'herb'
	if ingredient in ['egg','milk','cheese','flour','bread']:
		return ingredient
	if ingredient in ['trout','bluegill','carp']: 
		return 'fish'
	if ingredient in ['raspberry','wolfberry','apple']:
		return 'fruit'
	if ingredient in ['turnip','carrot','mushroom']:
		return 'vegetable'					
	
