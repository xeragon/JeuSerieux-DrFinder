extends Control
var listening = false
var wait=0
# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/result.text = GlobalScript.get_end_speech()
	$ColorRect/result.visible_ratio = 0
	%health_bar.value = GlobalScript.player_sante
	%serenity_bar.value = GlobalScript.player_stress

func _on_affiche_text_timeout():
	$ColorRect/result.visible_ratio += 0.01
	if $ColorRect/result.visible_ratio<1:
		$affiche_text.start()


func _on_replay_pressed():
	GlobalScript.replay()


func _on_button_pressed():
	get_tree().quit()
