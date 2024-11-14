class_name ItemData extends Resource

enum kywrds{Herb, Mushroom, Flower, Meal, Placeable, Consumable, Fish, Berry, Medicine,Ingredient}

@export var data_name:String
@export var name:String
@export var description:String
@export var keywords:Array[kywrds]
@export var value:int
@export var stackable:bool=true

@export var protein:int
@export var nutrients:int
@export var painkilling:int
@export var feverfighting:int
@export var decongestant:bool

@export var hp_recovered:int
@export var energy_recovered:int
@export var will_recovered:int
@export var hunger_recovered:int
