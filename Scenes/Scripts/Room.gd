extends Node

var room_id = '000001'
var room_name = 'Spawn'
var room_items = []
var room_enemy = null

func _ready():
	pass

func init(id, name, items):
	room_id = id
	room_name = name
	room_items = items