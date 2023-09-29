class_name Dialog
extends Control

@export var dialogue : Array[String];
@export var npc_name : String
var nb_dialogue : int
@onready var name_label = $VBoxContainer/name

func _ready():
	visible = false
	nb_dialogue = dialogue.size()
	

func _process(delta):
	var s = DisplayServer.window_get_size()
	
	$VBoxContainer/background.custom_minimum_size.x = s.x
	
	
	
func start_dialog():
	visible = true
	for i in range(nb_dialogue):
		if i % 2 == 0:
			set_dialogue_player()
			write_text(dialogue[i])
		else:
			set_dialogue_npc()
			write_text(dialogue[i])
		await get_tree().create_timer(2).timeout
	end_dialog()
	
func end_dialog():
	self.queue_free()
	
func set_dialogue_player():

	name_label.horizontal_alignment = 0
	name_label.text = GlobalScript.player_name
	
func set_dialogue_npc():
	name_label.horizontal_alignment = 2
	name_label.text = get_parent().name
	
func write_text(text : String):
	var text_holder = $VBoxContainer/background/text
	text_holder.text = ""
	for x in text:
		text_holder.text += x
		await get_tree().create_timer(0.05).timeout 
