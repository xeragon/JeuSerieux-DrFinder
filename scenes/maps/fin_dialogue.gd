extends Control
var listening = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(0.3) 


func _process(delta):
	if Input.is_action_pressed("ui_accept") and listening:
		get_tree().change_scene_to_file("res://scenes/maps/acceuil_et_portes.tscn")
		


func _on_timer_timeout():
	listening = true
