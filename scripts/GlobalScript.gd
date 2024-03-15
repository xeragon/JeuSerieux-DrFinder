extends Node

const BASE_STAT = 30
const WANTED_TOTAL_QUEUE = 25
const WANTED_TOTAL_QUEUE_SPE = 45

var is_reservation_used = false
var reserved_doc : String  
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
var is_reservation_over = false

var rng = RandomNumberGenerator.new()

enum DocType {DOC, SPE_DOC}

var docs_queue : Dictionary  = {
	"DrZen" : 0,
	"DrDroy" : 0,
	"DrZimZim" : 0,
	"DrFamille" : 0
	}
	
var spe_docs_queue : Dictionary  = {
	"DrChirurgien" : 0,
	"DrPsy" : 0
	}


var docs_queues : Dictionary = {
	
	DocType.DOC : {
		"wanted_total" : 25,
		"docs" : {
		"DrZen" : 0,
		"DrDroy" : 0,
		"DrZimZim" : 0,
		"DrFamille" : 0
		}
	},
	
	DocType.SPE_DOC : {
		"wanted_total" : 45,
		"docs" : {
			"DrChirurgien" : 0,
			"DrPsy" : 0
		}
	}
}



func reset_player_stat():
	player_sante = BASE_STAT
	player_stress = BASE_STAT
	
func _ready():
	reset_player_stat()
	set_docs_queue()
	
func reserve_doc(doc : String):
	reserved_doc = doc
	is_reservation_used = true
	
	
signal interaction_finished 

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
	is_reservation_over = false
	is_reservation_used = false
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
	modify_sante(-(docs_queue[doc_key]))

func set_docs_queue():
	var total : int = 0
	var total_spe : int = 0
	var n : int 
	
	for x in docs_queue:
		n = rng.randi_range(0,10)
		docs_queue[x] = n
		total += n
		
	for x in spe_docs_queue:
		n = rng.randi_range(10,20)
		docs_queue[x] = n
		total_spe += n

	if (total < WANTED_TOTAL_QUEUE):
		pump_up_queues(total,DocType.DOC)

	if (total_spe < WANTED_TOTAL_QUEUE_SPE):
		pump_up_queues(total_spe,DocType.SPE_DOC)

	if is_reservation_used and not is_reservation_over:
		if docs_queue.has(reserved_doc):
			docs_queue[reserved_doc] = 0
		else:
			spe_docs_queue[reserved_doc] = 0


func pump_up_queues(total : int , doc_type : DocType):
	var current_total = total
	var nb_point_to_distribute : int = WANTED_TOTAL_QUEUE - total
	var doc_key : String
	var doc_dico : Dictionary

	if doc_type == DocType.DOC:
		nb_point_to_distribute = WANTED_TOTAL_QUEUE - total
		for x in range(0,nb_point_to_distribute):
			doc_key = docs_queue.keys()[rng.randi_range(0,docs_queue.size()-1)]
			docs_queue[doc_key] += 1
			current_total += 1
	else:
		nb_point_to_distribute = WANTED_TOTAL_QUEUE_SPE - total
		for x in range(0,nb_point_to_distribute):
			doc_key = spe_docs_queue.keys()[rng.randi_range(0,spe_docs_queue.size()-1)]
			spe_docs_queue[doc_key] += 1
			current_total += 1
	print(current_total)



func better_pump_up_queues(total : int , doc_type : DocType):
	var current_total = total
	var doc_key : String
	var doc_dico : Dictionary = docs_queues[DocType]["docs"]
	var nb_point_to_distribute : int = docs_queues[DocType]["wanted_total"] - total

	for x in range(0,nb_point_to_distribute):
			doc_key = doc_dico.keys()[rng.randi_range(0,doc_dico.size()-1)]
			doc_dico[doc_key] += 1
			current_total += 1

	print(current_total)




func pump_down_queues(total : int, doc_type : DocType ):
	var current_total = total
	var doc_key : String
	var doc_dico : Dictionary

	if doc_type == DocType.DOC:
		while  current_total > WANTED_TOTAL_QUEUE:
			doc_key = docs_queue.keys()[rng.randi_range(0,docs_queue.size()-1)]
			if docs_queue[doc_key] - 1 > 0:
				docs_queue[doc_key] -= 1
				current_total -= 1
	else:
		while  current_total > WANTED_TOTAL_QUEUE_SPE:
			doc_key = spe_docs_queue.keys()[rng.randi_range(0,spe_docs_queue.size()-1)]
			if spe_docs_queue[doc_key] - 1 > 0:
				spe_docs_queue[doc_key] -= 1
				current_total -= 1

func get_round_start_str():
	return "Visite " + str(round_count)

func get_end_speech():
	var r = "";
	if player_sante == 100:
		if player_stress > 50:
			r += "[color=green]Félicitations ! vous voila rétablis et tout ca en restant serein ![color]"
		else:
			r += "[color=orange]Vous voila rétablis mais à quel prix ? Vous êtes maintenant traumatiser par le monde médical...[/color]"
	elif player_stress  == 100:
		if player_sante > 50:
			r += "[color=green]Pfiouu ! vous voila totalement rassuré, le reste de votre maladie s'effacera d'elle pas de quoi s'inquiter ! [/color]" 
		else:
			r += "[color=orange]Bon... vous êtes serein. C'est bien mais ca ne vous sauvera pas du cancer...[/color]"
	elif (player_sante + player_stress) >= 150:
		r = "[color=green]Bien jouer votre état de santé moyen est plus que correct ![/color]"
	else:
		r = "[color=red]Bon... vous ferez mieux la prochaine fois...[/color]"
	print(player_sante + player_stress)
	return r
