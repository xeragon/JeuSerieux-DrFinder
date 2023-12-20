extends Node

const BASE_STAT = 50
var str : String
var player_name : String
var player : Player
var current_map : map
var player_instance =  preload("res://scenes/player/player.tscn").instantiate()
var hud : CanvasLayer
var player_sante : int
var player_stress : int
var is_game_start : bool = true 
var round_count = 0;
var end_speech : String
signal interaction_finished 

func reset_player_stat():
	player_sante = BASE_STAT
	player_stress = BASE_STAT
	
func _ready():
	player_sante = BASE_STAT
	player_stress = BASE_STAT

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

func replay():
	round_count = 0;
	reset_player_stat()
	get_tree().change_scene_to_file("res://scenes/maps/acceuil_et_portes.tscn")
	
func next_round():
	if round_count == 3:
		change_map("res://scenes/maps/the_end.tscn")
	else:
		change_map("res://scenes/maps/fin_dialogue.tscn")
		round_count += 1;

func get_end_speech():
	var r = "";
	if player_sante == 100:
		if player_stress > 50:
			r += "Félicitations ! vous voila rétablis et tout ca en restant serein !"
		else:
			r += "Vous voila rétablis mais à quel prix ? Vous êtes maintenant traumatiser par le monde médical..."
	elif player_stress  == 100:
		if player_sante > 50:
			r += "Pfiouu ! vous voila totalement rassuré, le reste de votre maladie s'effacera d'elle pas de quoi s'inquiter !" 
		else:
			r += "Bon... vous êtes serein. C'est bien mais ca ne vous sauvera pas du cancer..."
	else:
		r = "Alors la vous êtes bien dans la merde..."
	return r
