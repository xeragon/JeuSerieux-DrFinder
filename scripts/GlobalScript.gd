extends Node

var player_name : String
var player : Player = null
var current_map : Node2D

var hud : CanvasLayer

func interaction_finished():
	player.interact_latency_timer.start()

func add_stress(value : int):
	player.emote.visible = true
	player.emote.play("sad")
	player.stress.value += value
func remove_stress(value : int):
	player.stress.value -= value
func add_sante(value:int):
	player.sante.value  += value
func remove_sante(value : int):
	player.sante.value  -= value
	
