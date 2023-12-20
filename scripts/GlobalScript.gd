extends Node

const BASE_STAT = 30
const WANTED_TOTAL_QUEUE = 50
var str : String
var player_name : String
var player : Player
var current_map : map
var player_instance =  preload("res://scenes/player/player.tscn").instantiate()
var hud : CanvasLayer
var player_sante : int
var player_stress : int
var is_game_start : bool = true 
var round_count = 1;
var end_speech : String

var rng = RandomNumberGenerator.new()

var docs_queue : Dictionary  = {
	"DrZen" : 0,
	"DrDroy" : 0,
	"DrZimZim" : 0,
	"DrChirurgien" : 0,
	"DrPsy" : 0,
	"DrFamille" : 0
	}


signal interaction_finished 
func reset_player_stat():
	player_sante = BASE_STAT
	player_stress = BASE_STAT
	
func _ready():
	reset_player_stat()
	set_docs_queue()

func emit_interaction_finished():
	emit_signal("interaction_finished")

func modify_stress(value : int):
	player.emote.visible = true
	if value > 0:
		player.emote.play("happy")
	else:
		player.emote.play("sad")
	player.stress.value += value
func modify_sante(value : int):
	player.emote.visible = true
	if value > 0:
		player.emote.play("happy")
	else:
		player.emote.play("sad")
	player.sante.value += value
	
func change_map(path_to_map : String):
	player_sante = player.sante.value
	player_stress = player.stress.value
	get_tree().change_scene_to_file(path_to_map)
	
func load_player_stats():
	player.sante.value = player_sante
	player.stress.value = player_stress

func replay():
	round_count = 1;
	reset_player_stat()
	get_tree().change_scene_to_file("res://scenes/maps/acceuil_et_portes.tscn")
	
func next_round():
	if round_count == 3:
		change_map("res://scenes/maps/the_end.tscn")
	else:
		change_map("res://scenes/maps/fin_dialogue.tscn")
		round_count += 1;
	set_docs_queue()

func apply_queue_debuff(doc_key : String):
	modify_stress(-(docs_queue[doc_key]))

func set_docs_queue():

	var total : int
	var n : int 
	
	for x in docs_queue:
		n = rng.randi_range(0,25)
		docs_queue[x] = n
		total += n
	
	if total > WANTED_TOTAL_QUEUE:
		pump_down_queues(total)
	elif total < WANTED_TOTAL_QUEUE:
		pump_up_queues(total)
	
	print(docs_queue)
	
func pump_up_queues(total : int ):
	var current_total = total
	var min_doc : String = "DrZen"
	while  current_total < WANTED_TOTAL_QUEUE:
		for x in docs_queue:
			if docs_queue[x] < docs_queue[min_doc]:
				min_doc = x
		docs_queue[min_doc] += 1
		current_total += 1 
		
func pump_down_queues(total : int ):
	var current_total = total
	var max_doc : String = "DrZen"
	while  current_total > WANTED_TOTAL_QUEUE:
		for x in docs_queue:
			if docs_queue[x] > docs_queue[max_doc]:
				max_doc = x
		docs_queue[max_doc] -= 1
		current_total -= 1

func get_round_start_str():
	return "Visite " + str(round_count)


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
