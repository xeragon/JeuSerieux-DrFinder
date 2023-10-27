extends map

func _ready():
	super._ready()

func _on_portes_medecin1_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/porte_medecin_1.tscn")


func _on_porte_medecins_2_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/porte_medecin_2.tscn")


func _on_porte_medecins_3_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/porte_medecin_3.tscn")


func _on_porte_medecins_4_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/porte_medecin_4.tscn")


func _on_porte_medecins_5_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/porte_medecin_5.tscn")


func _on_porte_medecins_6_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/maps/porte_medecin_6.tscn")
