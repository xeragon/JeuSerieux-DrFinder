extends map

@onready var secretaire : npc = %Secretaire
@onready var anim : AnimationPlayer = %AnimationPlayer
signal fondu_fini
func _ready():
	%fondu.visible = true
	%fondu.color.a = 1.0
	%fondu_timer.start()
	
	if GlobalScript.is_game_start:
		anim.play("game_start")
		GlobalScript.is_game_start = false
		
		
func interact_secretaire():
	secretaire.interact()

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


func _on_fondu_timer_timeout():
	if not %fondu.color.a < 0:
		%fondu.color.a -= 0.005
		%fondu_timer.start()
	else:
		emit_signal("fondu_fini")
	
