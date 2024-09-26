@tool
extends Node3D

const ROOM_TILE:int = 0
const HALLWAY_TILE:int = 1
const DOOR_TILE:int = 2
const BORDER_TILE:int = 3

@export var grid_map_path: NodePath
#Why not just export the grid map directly?
@onready var grid_map: GridMap = get_node(grid_map_path)


@export var start: bool = false : set = set_start

var dun_cell_scene: PackedScene = preload("res://MeshLibrary/DungeonCell.tscn")

var directions : Dictionary = {
	"n": Vector3i.FORWARD,
	"s": Vector3i.BACK,
	"w": Vector3i.LEFT,
	"e": Vector3i.RIGHT
}


func _ready() -> void:
	print("GridMap %s " % grid_map)


#Setters
func set_start(_val:bool)->void:
	if Engine.is_editor_hint():
		create_dungeon()



##Helpers##
#Handler Functions
func handle_none(cell:Node3D, dir: String ):
	cell.call("remove_door_"+dir)

# This naming convention uses the tile indexes of the types of tiles we care about
# i.e. handle_00 is going from a room tile (idx:0) to another room tile (idx:0)

#Room to Room 
func handle_00(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)
	cell.call("remove_door_"+dir)

#Room to Hallway
func handle_01(cell:Node3D, dir: String ):
	cell.call("remove_door_"+dir)

#Room to Door
func handle_02(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)
	cell.call("remove_door_"+dir)

#Hallway to Room
func handle_10(cell:Node3D, dir: String ):
	cell.call("remove_door_"+dir)

#Hallway to Hallway
func handle_11(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)
	cell.call("remove_door_"+dir)


#Hallway to Door
func handle_12(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)
	cell.call("remove_door_"+dir)


#Door to Room
func handle_20(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)
	cell.call("remove_door_"+dir)

#Door to Hallway
func handle_21(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)

#Door to Door
func handle_22(cell:Node3D, dir: String ):
	cell.call("remove_wall_"+dir)
	cell.call("remove_door_"+dir)


#func handle_corners(cell: Node3D ):
	#var idx = grid_map.get_cell_item(cell.position)
	#
	#var north_idx = grid_map.get_cell_item(cell.position + Vector3.FORWARD)
	#var south_idx = grid_map.get_cell_item(cell.position + Vector3.BACK)
	#var west_idx = grid_map.get_cell_item(cell.position + Vector3.LEFT)
	#var east_idx = grid_map.get_cell_item(cell.position + Vector3.RIGHT)
	#var nw_idx = grid_map.get_cell_item(cell.position + Vector3.FORWARD + Vector3.RIGHT)
	#var ne_idx = grid_map.get_cell_item(cell.position + Vector3.FORWARD + Vector3.LEFT)
	#var sw_idx = grid_map.get_cell_item(cell.position + Vector3.BACK + Vector3.LEFT)
	#var se_idx = grid_map.get_cell_item(cell.position + Vector3.BACK + Vector3.RIGHT)
	#
	#
	#var corners: Array[String] = []
	#
	#if _should_make_corner(idx, north_idx) && _should_make_corner(idx, west_idx):
		#corners.append("nw")
	#if _should_make_corner(idx, north_idx) && _should_make_corner(idx, east_idx):
		#corners.append("ne")
	#if _should_make_corner(idx, south_idx) && _should_make_corner(idx, west_idx):
		#corners.append("sw")
	#if _should_make_corner(idx, south_idx) && _should_make_corner(idx, east_idx):
		#corners.append("se")
	#
	##Handle Hallway inside corners
	#if idx == HALLWAY_TILE:
		##Corners with 3 hallway tiles
		#if north_idx == HALLWAY_TILE && west_idx == HALLWAY_TILE && _is_empty_tile(nw_idx) && nw_idx != DOOR_TILE:
			#corners.append("nw_inv")
		#if north_idx == HALLWAY_TILE && east_idx == HALLWAY_TILE && _is_empty_tile(ne_idx) && ne_idx != DOOR_TILE:
			#corners.append("ne_inv")
		#if south_idx == HALLWAY_TILE && west_idx == HALLWAY_TILE && _is_empty_tile(sw_idx) && sw_idx != DOOR_TILE:
			#corners.append("sw_inv")
		#if south_idx == HALLWAY_TILE && east_idx == HALLWAY_TILE && _is_empty_tile(se_idx) && se_idx != DOOR_TILE:
			#corners.append("se_inv")
		#
		##Corners with 2 Hallway tiles
		#if north_idx == HALLWAY_TILE \
			#&& _is_empty_tile(west_idx) \
			#&& _is_empty_tile(east_idx) \
			#&& _is_empty_tile(south_idx) \
			#&& _is_empty_tile(nw_idx) \
			#&& _is_empty_tile(ne_idx) \
			#&& _is_empty_tile(sw_idx) \
			#&& _is_empty_tile(se_idx):
			#corners.append_array(["sw", "se"])
		#
		#if south_idx == HALLWAY_TILE \
			#&& _is_empty_tile(west_idx) \
			#&& _is_empty_tile(east_idx) \
			#&& _is_empty_tile(north_idx) \
			#&& _is_empty_tile(nw_idx) \
			#&& _is_empty_tile(ne_idx) \
			#&& _is_empty_tile(sw_idx) \
			#&& _is_empty_tile(se_idx):
			#corners.append_array(["nw", "ne"])
		#
		#if east_idx == HALLWAY_TILE \
			#&& _is_empty_tile(west_idx) \
			#&& _is_empty_tile(south_idx) \
			#&& _is_empty_tile(north_idx) \
			#&& _is_empty_tile(nw_idx) \
			#&& _is_empty_tile(ne_idx) \
			#&& _is_empty_tile(sw_idx) \
			#&& _is_empty_tile(se_idx):
			#corners.append_array(["nw", "sw"])
		#
		#if west_idx == HALLWAY_TILE \
			#&& _is_empty_tile(east_idx) \
			#&& _is_empty_tile(south_idx) \
			#&& _is_empty_tile(north_idx) \
			#&& _is_empty_tile(nw_idx) \
			#&& _is_empty_tile(ne_idx) \
			#&& _is_empty_tile(sw_idx) \
			#&& _is_empty_tile(se_idx):
			#corners.append_array(["ne", "se"])
		#
		#
	#
	#
	#cell.call("remove_corners", corners)
	#
	#
	#
#
#func _should_make_corner(cur_idx: int, idx: int) -> bool:
	## True Conditions
	## 1. neighbor idx is Empty or neighbor idx is a border tile
	## 2. curr idx != idx && curr idx is not a room tile and idx is not a door tile
	#if _is_empty_tile(idx):
		#return true
	#if cur_idx != idx && (idx != DOOR_TILE && cur_idx != DOOR_TILE): 
		#return true
	##if cur_idx == idx && (cur_idx == HALLWAY_TILE && idx == HALLWAY_TILE):
		##return false
	#
	#return false
#
#func _is_empty_tile(idx: int):
	#return idx == grid_map.INVALID_CELL_ITEM || idx == BORDER_TILE

func create_dungeon():
	if(grid_map == null):
		grid_map = get_node(grid_map_path)
	
	for c in get_children():
		remove_child(c)
		c.queue_free()
	
	for cell in grid_map.get_used_cells():
		var cell_index : int = grid_map.get_cell_item(cell)
		if cell_index <= DOOR_TILE && cell_index >= ROOM_TILE:
			var dun_cell: Node3D = dun_cell_scene.instantiate()
			dun_cell.position = Vector3(cell) #+ Vector3(0.5, 0, 0.5) #This offest should be a const
			add_child(dun_cell)
			dun_cell.set_owner(owner)
			for i in 4: #Number of sides of a room
				var cell_n: Vector3i  = cell + directions.values()[i]
				var cell_n_index: int = grid_map.get_cell_item(cell_n)
				if cell_n_index == -1 || cell_n_index == BORDER_TILE:
					handle_none(dun_cell, directions.keys()[i])
				else:
					var key: String = str(cell_index) + str(cell_n_index)
					call("handle_"+key, dun_cell, directions.keys()[i])
			#handle_corners(dun_cell)
				
	
