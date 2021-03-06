extends PanelContainer

# unit info
var p_name = 'Argus'

onready var hp_bar = get_node('Info_Box/HP/Bar')
onready var mp_bar = get_node('Info_Box/MP/Bar')

# Called when the node enters the scene tree for the first time.
func _ready():
	set_name(p_name)

# Set name on label
func set_name(n):
	p_name = n
	var name_label = get_node('Info_Box/Name/Label')
	name_label.set_text(n)

func update_max_hp(val):
	hp_bar.max_value = val

func update_max_mp(val):
	mp_bar.max_value = val

func update_hp(val):
	hp_bar.value += val

func update_mp(val):
	mp_bar.value += val

func set_hp(val):
	hp_bar.value = val

func set_mp(val):
	mp_bar.value = val