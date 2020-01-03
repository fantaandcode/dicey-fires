extends PanelContainer

# initialize rng and result
var rng = RandomNumberGenerator.new()
var result = 0
var turn = true

var dice = []
var rolls_max = 0
var rolls_left = 0
var dice_rolls = []
onready var dice_val = get_node("Dice/Dice_Values")
onready var roll_button = get_node("Dice/Roll_Info/Roll_Button")
onready var rolled_display = get_node("Dice/Roll_Info/Rolled_Display")

func _ready():
	# new random every run
	rng.randomize()

# initialize Dice_Info
func init_dice_display():
	rolls_left = rolls_max
	display_dice()
	set_roll_button_texture()
	rolled_display.columns = dice.size() - 1
	
	for i in range(rolls_max):
		var tmp = TextureRect.new()
		tmp.texture = get_dice_sprite(dice.size(), 0)
		rolled_display.add_child(tmp)

# set roll button texture
func set_roll_button_texture():
	var value = ''
	if rolls_left > 0:
		value = 'can_roll'
	else:
		value = 'no_roll'
	
	roll_button.set_normal_texture(get_dice_sprite(dice.size(), value))
	roll_button.set_pressed_texture(get_dice_sprite(dice.size(), value))
	roll_button.set_hover_texture(get_dice_sprite(dice.size(), value))
	roll_button.set_disabled_texture(get_dice_sprite(dice.size(), value))
	roll_button.set_focused_texture(get_dice_sprite(dice.size(), value))

# get dice sprite
func get_dice_sprite(size, num):
	return load('res://Sprites/d' + String(size) + '/d' + String(size) + '_'+String(num)+'.png')

# shows dice on dice panel
func display_dice():
	for i in dice:
		var DI = TextureRect.new()
		DI.texture = get_dice_sprite(dice.size(), i)
		dice_val.add_child(DI)

# set the result on dice panel
func set_result():
	if rolls_left >= 0:
		rolled_display.get_children()[rolls_max - rolls_left - 1].texture = get_dice_sprite(dice.size(), result)
		set_roll_button_texture()
	else:
		print("No more rolls")

# roll dice
func roll_dice():
	var rand = rng.randi_range(0, dice.size()-1)
	result = dice[rand]
	dice_rolls.append(result)
	rolls_left -= 1
	set_result()

func reset_rolls():
	for i in rolled_display.get_children():
		i.texture = get_dice_sprite(dice.size(), 0)

func make_enemy_dice():
	get_node("Dice/Roll_Info/Roll_Button").queue_free()
	get_node("Dice/Roll_Info/Rolled_Display").columns = dice.size()

# when roll dice button is pressed
func _on_Roll_Button_pressed():
	if turn:
		roll_dice()