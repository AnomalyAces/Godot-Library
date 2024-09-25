@tool
extends Node3D

func remove_wall_corner_ne():
	$wall_corner_NE.free()
func remove_wall_corner_nw():
	$wall_corner_NW.free()
func remove_wall_corner_sw():
	$wall_corner_SW.free()
func remove_wall_corner_se():
	$wall_corner_SE.free()
func remove_corners(corners_to_keep: Array[String]):
	#TODO - handle logic to remove all corners not included
	pass
func remove_wall_n():
	$wall_N.free()
func remove_door_n():
	$wall_doorway_N.free()
func remove_wall_s():
	$wall_S.free()
func remove_door_s():
	$wall_doorway_S.free()
func remove_wall_e():
	$wall_E.free()
func remove_door_e():
	$wall_doorway_E.free()
func remove_wall_w():
	$wall_W.free()
func remove_door_w():
	$wall_doorway_W.free()
