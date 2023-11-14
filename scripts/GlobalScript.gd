extends Node

var player_name : String
var player : Player
var current_map : Node2D
var player_instance =  preload("res://scenes/player/player.tscn").instantiate()
var hud : CanvasLayer
var player_sante : int
var player_stress : int

var current_map_top_right : Marker2D
var current_map_bottom_left : Marker2D

signal interaction_finished 
func _ready():
	player_sante = 50
	player_stress = 50
	
#func interaction_finished():
#	player.interact_latency_timer.start()

func emit_interaction_finished():
	emit_signal("interaction_finished")
func modify_stress(value : int):
	player.emote.visible = true
	if value > 0:
		player.emote.play("sad")
	else:
		player.emote.play("happy")
	player.stress.value += value
	
func modify_sante(value : int):
	player.emote.visible = true
	if value > 0:
		player.emote.play("sad")
	else:
		player.emote.play("happy")
	player.sante.value += value
	
func change_map(path_to_map : String):
	player_sante = player.sante.value
	player_stress = player.stress.value
	get_tree().change_scene_to_file(path_to_map)
	
func load_player_stats():
	player.sante.value = player_sante
	player.stress.value = player_stress
	player.camera.limit_top = current_map_top_right.y
	player.camera.limit_right = current_map_top_right.x
	player.camera.limit_botom = current_map_bottom_left.y
	player.camera.limit_left = current_map_bottom_left.x
