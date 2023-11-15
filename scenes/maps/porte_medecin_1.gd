extends map

func _enter_tree():
	super._enter_tree()
	
func _ready():
	super._ready()
	self.focus_on_map.emit()
	$AnimationPlayer.play("entering_room")
	GlobalScript.interaction_finished.connect(_on_interaction_finished)

func exit_room():
	GlobalScript.change_map("res://scenes/maps/fin_dialogue.tscn")

func _on_interaction_finished():
	$AnimationPlayer.play("quit_room")
