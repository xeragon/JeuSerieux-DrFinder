extends Node

var player_name : String
var player : Player
var current_map : map
var player_instance =  preload("res://scenes/player/player.tscn").instantiate()
var hud : CanvasLayer
var player_sante : int
var player_stress : int


signal interaction_finished 

func _ready():
	player_sante = 50
	player_stress = 50

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

