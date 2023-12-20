class_name npc

extends CharacterBody2D

@export var npc_name : String

var player_in_range : bool
var dialog_is_playing : bool

func _interact(dialogue : String):
	print("SUOER")
	DialogueManager.show_example_dialogue_balloon(load("res://dialog/"+ dialogue +".dialogue"),"start")

