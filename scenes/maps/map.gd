extends map


func _ready():
	super._ready()
	
func _on_blue_building_door_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/map_inside_blue_building.tscn")
