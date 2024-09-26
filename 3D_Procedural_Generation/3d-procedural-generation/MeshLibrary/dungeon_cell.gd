@tool
class_name DungeonCell extends Node3D


func show_wall_corner_ne():
	$wall_corner_NE.visible= true
func show_wall_corner_nw():
	$wall_corner_NW.visible= true
func show_wall_corner_sw():
	$wall_corner_SW.visible= true
func show_wall_corner_se():
	$wall_corner_SE.visible= true
func show_wall_corner_ne_inv():
	$wall_corner_NE_Inv.visible= true
func show_wall_corner_nw_inv():
	$wall_corner_NW_Inv.visible= true
func show_wall_corner_sw_inv():
	$wall_corner_SW_Inv.visible= true
func show_wall_corner_se_inv():
	$wall_corner_SE_Inv.visible= true
func remove_wall_corner_ne():
	$wall_corner_NE.visible = false
func remove_wall_corner_nw():
	$wall_corner_NW.visible = false
func remove_wall_corner_sw():
	$wall_corner_SW.visible = false
func remove_wall_corner_se():
	$wall_corner_SE.visible = false
func remove_wall_corner_ne_inv():
	$wall_corner_NE_Inv.visible = false
func remove_wall_corner_nw_inv():
	$wall_corner_NW_Inv.visible = false
func remove_wall_corner_sw_inv():
	$wall_corner_SW_Inv.visible = false
func remove_wall_corner_se_inv():
	$wall_corner_SE_Inv.visible = false
func remove_corners(corners_to_keep: Array[String]):
	var corner_list: Array[String] = ["ne", "nw", "se", "sw", "ne_inv", "nw_inv", "se_inv", "sw_inv"]
	for c in corner_list:
		if !corners_to_keep.has(c):
			call("remove_wall_corner_"+c)
		else:
			call("show_wall_corner_"+c)
func remove_wall_n():
	$wall_N.visible = false
func remove_door_n():
	$wall_doorway_N.visible = false
func remove_wall_s():
	$wall_S.visible = false
func remove_door_s():
	$wall_doorway_S.visible = false
func remove_wall_e():
	$wall_E.visible = false
func remove_door_e():
	$wall_doorway_E.visible = false
func remove_wall_w():
	$wall_W.visible = false
func remove_door_w():
	$wall_doorway_W.visible = false
