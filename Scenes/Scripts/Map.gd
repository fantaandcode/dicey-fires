extends VBoxContainer

var map = []
var map_size = 10

var room_resource = preload('res://Scenes/Room.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	init_map()

func init_map():
	for i in range(0, map_size):
		map.append([])
		for j in range(0, map_size):
			map[i].append(0)
		
	map[1][2] = new_room('000001', 'Spawn', [])
	map[1][3] = new_room('000002', 'Left', [])
	map[2][2] = new_room('000003', 'South', [])
	
	for i in range(0, map_size):
		print(map[i])

func new_room(id, name, items):
	var room = room_resource.instance()
	room.init(id, name, items)