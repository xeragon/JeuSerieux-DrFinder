extends Node

var player_name : String
var player = null
var current_map : Node2D

var hud : CanvasLayer

func interaction_finished():
	player.interacting = false
	
	
