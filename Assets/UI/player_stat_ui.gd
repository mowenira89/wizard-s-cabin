extends Control

@onready var hp_bar: ProgressBar = $GridContainer/HPBar
@onready var energy_bar: ProgressBar = $GridContainer/EnergyBar
@onready var hunger_bar: ProgressBar = $GridContainer/HungerBar
@onready var will_bar: ProgressBar = $GridContainer/WillBar


func _ready():
	Signals.set_player_bars.connect(set_bars)

func set_bars():
	var p = PlayerManager.data
	hp_bar.max_value=p.max_hp
	hp_bar.value=p.hp
	energy_bar.max_value=p.max_energy
	energy_bar.value = p.energy
	will_bar.max_value=p.max_will
	will_bar.value=p.will
	hunger_bar.max_value=100
	hunger_bar.value=p.hunger
