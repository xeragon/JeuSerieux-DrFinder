extends Node

var player_name : String
var player : player = null
var current_map : Node2D

var hud : CanvasLayer

func interaction_finished():
	player.interact_latency_timer.start()
	
func modify_stress(value : int):
	pass
	
func modify_sante(value : int):
	pass
