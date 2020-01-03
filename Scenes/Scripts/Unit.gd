extends VBoxContainer

var unit_name = 'Argus'
var unit_class = 'commoner'
# warning-ignore:unused_class_variable
var is_player = true

onready var dice_obj = get_node('Dice_Panel')
onready var unit_disp = get_node('Unit_Display')

var dice = []
var rolls_max = 3

var max_hp = 20
var max_mp = 10
var hp = 0
var mp = 0

var st = 10
var dx = 10
var iq = 10
var ht = 20

func _ready():
	# init unit display
	unit_disp.set_name(unit_name)
	hp = max_hp
	mp = max_mp
	unit_disp.init_hp_and_mp(max_hp, hp, max_mp, mp)
	
	# init dice
	dice = class_dice()
	dice_obj.dice = dice
	dice_obj.rolls_max = rolls_max
	dice_obj.init_dice_display()
	
	# set max stats
	hp = max_hp
	mp = max_mp

# set dice based on class
func class_dice():
	if unit_class == 'commoner':
		return [1, 2, 3, 4, 5, 6]
	elif unit_class == 'peasant':
		return [0, 3, 3, 4, 5, 6]
	else:
		return [1, 2, 3, 4, 5, 6]

func set_unit_name(n):
	unit_disp.set_name(n)

func init_enemy_dice():
	dice_obj.make_enemy_dice()

func get_dice_rolls():
	return dice_obj.dice_rolls

func clear_dice_rolls():
	dice_obj.dice_rolls.clear()

func reset_rolls():
	dice_obj.dice_rolls.clear()
	dice_obj.rolls_left = rolls_max
	dice_obj.reset_rolls()
	if is_player:
		dice_obj.set_roll_button_texture()

func update_hp(val):
	unit_disp.update_hp(val)

func update_mp(val):
	unit_disp.update_mp(val)