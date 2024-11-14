extends Node

var nodes = {}
var loots = {'dandelion':20,'poppy':20, 'mushroom':20,'rosemary':15, 'thyme':15, 'feverfew':10}

func get_loot():
	var total=0
	var loot_list=[]
	for x in loots:
		loot_list.append(x)
		total+=loots[x]
	while total>0:
		var loot = loot_list.pick_random()
		total-=loots[loot]
		if total<=0: 
			return loot
