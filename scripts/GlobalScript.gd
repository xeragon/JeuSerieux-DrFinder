extends Node

var player_name : String
var player : Player = null
var current_map : Node2D

var hud : CanvasLayer

func interaction_finished():
	player.interact_latency_timer.start()
	
func modify_stress(value : int):
	player.emote.visible = true
	if value > 0:
		player.emote.play("sad")
	else:
		player.emote.play("happy")
	player.stress.value += value
	
func modify_sante(value : int):
	pass
