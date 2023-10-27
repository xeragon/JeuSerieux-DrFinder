extends map


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


func _on_retour_body_entered(body):
	if(body.has_method("player")):
		GlobalScript.change_map("res://scenes/maps/fin_dialogue.tscn")
