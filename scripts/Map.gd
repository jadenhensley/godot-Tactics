extends Node2D

class_name Map

@onready var grid_size: Vector2i = Vector2i(12,8);
@onready var cell_size: int = 32;
@onready var screen_offset: Vector2i = Vector2i(64,64);
@onready var map: Array[Array];
@onready var ENEMY_COUNT: int = 6

@export var sharedData: ActionData

# Called when the node enters the scene tree for the first time.
func _ready():
	map = construct_map()
	print_map(map)
	spawn_enemies()
	print_map(map)

func spawn_enemies():
	var existing_spawns_arr: Array[Vector2i] = []
	if map != null:
		for idx in range(ENEMY_COUNT):
			var spawn_pos = get_enemy_spawn_pos()
			if spawn_pos in existing_spawns_arr:
				while spawn_pos in existing_spawns_arr:
					spawn_pos = get_enemy_spawn_pos()
			existing_spawns_arr.append(spawn_pos)
			var obj = randi() % 3
			set_object_at_point(obj, spawn_pos.x, spawn_pos.y, ActionData.Team.CPU)

func get_enemy_spawn_pos() -> Vector2i:
	var posAt = Vector2i()
	posAt.x = grid_size.x - 1 - (randi_range(1,3))
	posAt.y = randi_range(1,grid_size.y - 1)
	return posAt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("mmb"):
		if sharedData != null:
			sharedData.selected_object = (sharedData.selected_object + 1) % 3
	
	var mouse_pos = get_global_mouse_position()
	var local_pos = Vector2i(
		(mouse_pos.x - screen_offset.x) / cell_size,	
		(mouse_pos.y - screen_offset.y) / cell_size,	
	)
	var mouse_x_is_in_bounds = (not mouse_pos.x <= screen_offset.x)
	var mouse_y_is_in_bounds = (not mouse_pos.y <= screen_offset.y)
	if Input.is_action_just_released("lmb"):
		if mouse_x_is_in_bounds and mouse_y_is_in_bounds:			
			var err = set_object_at_point(Character.BoardObject.Fighter, local_pos.x, local_pos.y, ActionData.Team.Player)
			print_map(map)
			print(local_pos.x, " , ", local_pos.y)
			#print(x_is_valid(local_pos.x))
			#print(y_is_valid(local_pos.y))
			#print(is_my_enum(BoardObject.Fighter))
			print(err)
			#print("Is shorter X: ", mouse_pos.x <= screen_offset.x)
			#print("Is shorter Y: ", mouse_pos.y <= screen_offset.y)
	
	
	#if Input.is_action_just_released("rmb"):
		## note(jaden): this is temporary, obviously not good game design.
		#if mouse_x_is_in_bounds and mouse_y_is_in_bounds:
			#print("Trying to delete board object: ")
			#var err = del_object_at_point(local_pos.x, local_pos.y)
			#print(err)

func construct_map():
	# todo(jaden): change this to use Real game objects. and default to None/null.
	var grid: Array[Array] = []
	for rowIdx in range(grid_size.y):
		var row: Array[Character] = [];
		for colIdx in range(grid_size.x):
			var currObj = null
			#if colIdx == 0:
				#currObj = Character.new(Character.BoardObject.Fighter)
			row.append(currObj)
		grid.append(row)
	return grid

func print_map(argMap: Array[Array]):
	print("========================================")
	for row in argMap:
		var strRow = ""
		for obj in row:
			if obj == null:
				strRow += "."
			else:
				if obj is Character:
					strRow += get_char_of_object(obj.my_class)
		print(strRow)
	print("========================================")	
		
func x_is_valid(x: int) -> bool:
	return (x >= 0 and x < grid_size.x)

func y_is_valid(y: int) -> bool:
	return (y >= 0 and y < grid_size.y)

func is_my_enum(obj) -> bool:
	# Checks if the object is a Dictionary and shares the exact keys
	return ( obj in [Character.BoardObject.Mage, Character.BoardObject.Fighter, Character.BoardObject.Archer] )
	#return typeof(obj) == TYPE_DICTIONARY and obj.has_all(BoardObject.keys())

func del_object_at_point(x: int, y: int) -> bool:
	if x_is_valid(x) and y_is_valid(y):
		var slot_exists = (map[y][x] is Character)
		if slot_exists:
			map[y][x].queue_free()
			map[y][x] = null
			return true
	return false

func set_object_at_point(obj: Character.BoardObject, x: int, y: int, team: ActionData.Team) -> bool:
	if x_is_valid(x) and y_is_valid(y):
		var slot_exists = (map[y][x] is Character)
		if (slot_exists):
			print("Character already is in this slot. not adding again.")
			return false
	if is_my_enum(obj) and x_is_valid(x) and y_is_valid(y):
		var currCharacter = Character.new(obj, x, y, team)
		if team == ActionData.Team.Player:
			if sharedData != null:
				currCharacter.my_class = sharedData.selected_object
		map[y][x] = currCharacter
		#currCharacter.my_screen_obj.visible = true
		#get_tree().current_scene.add_child(currCharacter)
		var canvas = get_tree().current_scene.get_node("CanvasLayer")
		currCharacter.my_screen_obj.z_index = 100
		canvas.add_child(currCharacter)
		# get_tree().current_scene.add_child(currCharacter.my_screen_obj)
		return true
	return false # nothing happened.
	
func get_char_of_object(obj: Character.BoardObject) -> String:
	if (obj == Character.BoardObject.Mage):
		return "m"
	if (obj == Character.BoardObject.Fighter):
		return "f"
	if (obj == Character.BoardObject.Archer):
		return "a"
	return "."
