class_name Sibling extends Entity


var liked_foods = []
var disliked_foods= []
var liked_gift= []
var disliked_gift= []
var liked_scents= []
var disliked_scents= []

var in_bed:bool=false

var love:int=50
var hate:int=0
var happysad:int=50

var disease_strength:int=50
var pain:int=2
var fever:bool=false
var fever_level:int=0
var days_fevered:int=0

var sore_throat:bool=false
var stuffy_nose:bool=false
var insomnia:bool=false
var restlessness:int=0
var hours_without_sleep:int=0
var temperature:int
var asleep:bool=false

var gifts = []

func _ready():
	Clock.one_hour.connect(one_hour)
	Clock.day_passed.connect(new_day)
	
	
func new_day():
	var symptoms=[sore_throat,stuffy_nose,insomnia,fever]
	var s = symptoms.pick_random()
	s=true
	match s:
		sore_throat: 
			pain+=1
			energy-=10
		fever: 
			fever_level+=1
			energy-=20

func set_sibling():
	var flavors = InvManager.flavors
	liked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	if randi()%100>50:
		liked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	if randi()%100>80:
		liked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	disliked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	if randi()%100>50:
		disliked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	if randi()%100>50:
		disliked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	if randi()%100>80:
		disliked_foods.append(flavors.pop_at(randi_range(0,flavors.size())))
	
	var incenses = InvManager.incenses
	liked_scents.append(incenses.pick_random())
	if randi()%50:	liked_scents.append(incenses.pick_random())
	disliked_scents.append(incenses.pick_random())
	if randi()%50: 	disliked_scents.append(incenses.pick_random())


	
	
	
func one_hour():
	disease_strength+=randi_range(-15,15)
	if malnutrition:disease_strength+=10
	if disease_strength>strength*2:
		change_hp(-1)
		
func one_minute():
	if CabinManager.temp<65:
		in_bed=true
	if CabinManager.temp>65:
		in_bed=false
		
	var temp = CabinManager.temp
	if in_bed:temp+=5
	if temp<65:change_strength(-1)
		
	for x in CabinManager.odors:
		if x is EventObject:
			if x.incense in liked_scents:
				happiness+=1
			if x.incense in disliked_scents:
				happiness-=1
	

func change_strength(d:int):
	strength+=d
	
func eat(food:Meal):
	super.eat(food)
	for i in food.ingredients:
		if i in liked_foods:change_happiness(10)
		if i in disliked_foods:change_happiness(-10)
		
	for x in food.ingredients:
		var d = load("res://Assets/Resources/Items/"+x+".tres")
		if d.painkilling:
			change_pain(d.painkilling)
		if d.feverfighter:
			change_fever_level(d.feverkilling)
		if d.decongestant:
			stuffy_nose=false
		
func change_pain(d:int):
	pain = clamp(pain+d,0,10)
	
func change_fever_level(d:int):
	fever_level=clamp(fever_level+d,0,10)
