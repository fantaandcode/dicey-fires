extends VBoxContainer

# whose turn is it? true is player, false is enemy
var turn = true

# player and enemy
onready var player = get_node('Profiles/Player')
var enemy = null

# signals
signal name_changed

# called on initialization
func _ready():
	# create test fight
	player_creation()
	enemy_creation()

# create player
func player_creation():
	# change in future
	# TODO
	player.set_unit_name('Trent')

# create enemy
func enemy_creation():
	# TODO
	enemy = preload('res://Scenes/Unit.tscn').instance()
	enemy.name = 'Enemy'
	get_node('Profiles').add_child(enemy)
	enemy.set_unit_name('Shadow')
	enemy.is_player = false
	enemy.init_enemy_dice()

# called on every frame, unused for now
func _process(delta):
	pass

func play_round(attacker, defender):
	var vals = attacker.get_dice_rolls()
	var total = 0
	
	for i in vals:
		total += i
	
	print(attacker.name + ' total: ', total)
	turn = not turn
	defender.update_hp(-total)

func units_reset():
	player.reset_rolls()
	enemy.reset_rolls()

func _on_End_Turn_pressed():
	play_round(player, enemy)
	play_round(enemy, player)
	units_reset()