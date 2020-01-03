extends VBoxContainer

# initialize rng
var rng = RandomNumberGenerator.new()

# player info
var _name = 'Argus'
var _class = 'Commoner'

# dice
var dice = [1, 2, 3, 4, 5, 6]
onready var dice_obj = get_node('Info_Box/Dice')
var dice_rolls = []
var max_rolls = 3
var rolls = 0	# number of dice rolls player has

# turn priority
var priority = 0

# player health and mana
var hp = 0
var mp = 0
var max_hp = 20
var max_mp = 10

onready var hp_bar = get_node('Info_Box/HP/Bar')
onready var mp_bar = get_node('Info_Box/MP/Bar')

# can roll signal
signal can_roll
signal cannot_roll

# Called when the node enters the scene tree for the first time.
func _ready():	
	# set the number of rolls the player has to the maximum rolls
	rolls = max_rolls
	
	# initialize player status stats
	update_max_hp(max_hp)
	update_max_mp(max_mp)
	update_hp(max_hp)
	update_mp(max_mp)
	
	# randomize for every run
	rng.randomize()
	priority = rng.randi_range(0, 100)

# sets bar max
func update_max_hp(val):
	max_hp = val
	hp_bar.max_value = val

func update_max_mp(val):
	max_mp = val
	mp_bar.max_value = val

# sets player label
func set_name(n):
	_name = n
	var name_label = get_node('Info_Box/Name/Label')
	name_label.set_text(n)

# update hp, val is change in hp
func update_hp(val):
	hp += val
	hp_bar.value += val
	if hp <= 0:
		print('player is dead')
		max_rolls = 0
		rolls = max_rolls
		dice_obj.death(_name)

# update mp, val is change in mp
func update_mp(val):
	mp += val
	mp_bar.value += val

# disable dice when not player's turn
func disable_dice():
	dice_obj.turn = false

func enable_dice():
	dice_obj.turn = true

# if dice button is rolled, parse roll
func _on_Dice_roll_button_pressed():
	if rolls > 0:
		rolls -= 1
		dice_rolls.append(dice_obj.roll_dice())
		emit_signal("can_roll")
#		print(rolls)
#		print(dice_rolls)
	else:
		rolls = 0
		emit_signal("cannot_roll")