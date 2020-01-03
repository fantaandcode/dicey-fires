extends Button

var rng = RandomNumberGenerator.new()
var result = 0

onready var dice = get_node("/root/root/Player_Info").dice
onready var label = get_node("../Result_Label/Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	roll_dice()
	show_dice()

func _on_Roll_Button_pressed():
	roll_dice()

# roll dice once
func roll_dice():
	var rand = rng.randi_range(0, dice.size()-1)
	print("Roll: ", dice[rand])
	set_result(dice[rand])

# shows dice on the dice panel
func show_dice():
	var dice_val = get_node("../Dice_Values/Label")
	dice_val.text = ' '
	for i in dice:
		dice_val.text += String(i) + '  '

func set_result(value):
	label.text = String(value)