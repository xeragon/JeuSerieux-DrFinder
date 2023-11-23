extends Control
var listening = false
var wait=0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(0.3) 
	$ColorRect/summary.visible_ratio=0
	$ColorRect/health_bar.value=GlobalScript.player_sante
	$ColorRect/stress_bar.value=GlobalScript.player_stress
	

func _process(delta):
	
	if Input.is_action_pressed("ui_accept") and listening:
		get_tree().change_scene_to_file("res://scenes/maps/acceuil_et_portes.tscn")

func _on_timer_timeout():
	listening = true


func _on_affiche_text_timeout():
	$ColorRect/summary.visible_ratio += 0.01
	if $ColorRect/summary.visible_ratio<1:
		$affiche_text.start()
