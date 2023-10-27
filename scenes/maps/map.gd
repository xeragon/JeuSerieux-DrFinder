extends map


func _ready():
	super._ready()
	
func _on_blue_building_door_body_entered(body):
	if body.has_method("player"):
		GlobalScript.change_map("res://scenes/maps/acceuil_et_portes.tscn")
		#get_tree().change_scene_to_file("res://scenes/maps/acceuil_et_portes.tscn")
