extends VBoxContainer

# whose turn is it? true is player, false is enemy
var turn = true

# player and enemy
onready var player = get_node('Profiles/Player')
onready var notice_panel = get_node('Notices')
onready var action_panel = get_node('Actions')
onready var hand = get_node('Hand')
onready var state_label = get_node('Debug/Container/State_Label')
var max_hand_size = 5
var enemy = null

var round_ct = 0

# signals
signal name_changed

# game state variables, starts in idle
enum {STATE_IDLE = 0, STATE_COMBAT = 1, STATE_SHOP = 2, STATE_STORY = 3}
var game_state = STATE_IDLE

# called on initialization
func _ready():
	# continuously check the game state
	check_state()

func check_state():
	match game_state:
		STATE_IDLE:
			state_label.text = String(game_state) + ': ' + 'Idle'
			to_idle()
		STATE_COMBAT:
			if get_node('Profiles').get_children().size() < 2:
				state_label.text = String(game_state) + ': ' + 'Combat'
				to_combat()
				start_fight()
		STATE_SHOP:
			state_label.text = String(game_state) + ': ' + 'Shop'
		STATE_STORY:
			state_label.text = String(game_state) + ': ' + 'Story'
		_:
			state_label.text = String(game_state) + ': ' + 'Invalid state'

func to_idle():
	hand.visible = false
	action_panel.visible = false
	
func to_combat():
	hand.visible = true
	action_panel.visible = true

func start_fight():
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
	# set node name
	enemy.name = 'Enemy'
	get_node('Profiles').add_child(enemy)
	
	# set all enemy information
	enemy.set_unit_name('Shadow')
	enemy.is_player = false
	enemy.init_enemy_dice()

# play a round
func play_round(attacker, defender):
	if attacker.is_dead:
		print(attacker.name + ' is dead')
		return null
	else:
		var vals = attacker.get_dice_rolls()
		var total = 0
		
		for i in vals:
			total += i
		
		print(attacker.name + ' total: ', total)
		turn = not turn
		defender.update_hp(-total)
		
		# check if dead
		if defender.is_dead:
			defender.unit_disp.set_name('Dead')

func units_reset():
	player.reset_rolls()
	enemy.reset_rolls()

func print_round():
	print('==========\nRound:', round_ct, '\n==========')
	round_ct += 1

func _on_End_Turn_pressed():
	print_round()
	play_round(player, enemy)
	print_round()
	play_round(enemy, player)
	units_reset()

func _on_Deck_pressed():
	var cards_in_hand = hand.get_children().size() - 1
	if cards_in_hand < max_hand_size:
		var tmp_card = preload('res://Scenes/Card.tscn').instance()
		hand.add_child(tmp_card)
	elif cards_in_hand == max_hand_size:
		var notice = preload('res://Scenes/Hand_Full_Notice.tscn').instance()
		notice_panel.add_child(notice)

func _on_Player_no_rolls_left():
	var notice = preload('res://Scenes/No_Rolls_Notice.tscn').instance()
	notice_panel.add_child(notice)

func _on_Button_pressed():
	game_state = STATE_COMBAT
	check_state()