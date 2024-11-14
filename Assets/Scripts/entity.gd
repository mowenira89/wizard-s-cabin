class_name Entity extends Resource

@export var max_hp:int
@export var hp:int
@export var max_will:int
@export var will:int
@export var max_energy:int
@export var energy:int
@export var hunger:int
@export var strength:int
@export var max_strength:int
@export var charisma:int

var protein:int=50
var nutrients:int=50
var malnutrition:bool
var days_malnutrition:float=0

var happiness:int=50

var relationships = []
var buffs = []


func change_hunger(d:int):
	hunger = clamp(hunger+d,0,100)
	
func change_hp(d:int):
	hp= clamp(hp+d,0,max_hp)
	if hp==0:Signals.death.emit(self)
	
func change_will(d:int):
	will=clamp(will+d,0,max_will)
	
func change_energy(d:int):
	energy = clamp(energy+d,0,max_energy)

func change_happiness(d:int):
	happiness=clamp(happiness+d,0,100)

func change_strength(d:int):
	strength=clamp(strength+d,0,max_strength)

func change_protein(d:int):
	protein=clamp(protein+d,0,100)

func change_nutrients(d:int):
	nutrients=clamp(nutrients+d,0,100)


func eat(food:Meal):
	var data = food.data
	change_energy(data.energy_recovered)
	change_hp(data.hp_recovered)
	change_will(data.will_recovered)
	for x in food.ingredients:
			var d = load("res://Assets/Resources/Items/"+x+".tres")
			change_protein(d.protein)
			change_nutrients(d.nutrients)
			
			
