extends map

@onready var secretaire : npc = %Secretaire
@onready var anim : AnimationPlayer = %AnimationPlayer
var is_start_label_done = false
signal fondu_fini

func _ready():
	%fondu.visible = true
	%fondu.color.a = 1.0
	%fondu_timer.start()
	
	self.fondu_fini.connect(_on_fondu_fini)
	
	%round_label.modulate.a = 0 
	%round_label.text = GlobalScript.get_round_start_str()
	var node : Label
	for x in GlobalScript.docs_queue:
		node = get_node("porte_" + x + "/panneau/Label")
		node.text = str(GlobalScript.docs_queue[x])

	
	if GlobalScript.is_game_start:
		anim.play("game_start")
		GlobalScript.is_game_start = false


func interact_secretaire():
	secretaire.interact()

func _on_fondu_fini():
	%fondu_label.start()

func _on_fondu_timer_timeout():
	if not %fondu.color.a < 0:
		%fondu.color.a -= 0.005
		%fondu_timer.start()
	else:
		emit_signal("fondu_fini")

func _on_fondu_label_timeout():
	if  %round_label.modulate.a <= 1 and not is_start_label_done:
		%round_label.modulate.a += 0.01
		%fondu_label.start(0.001)
	elif is_start_label_done and %round_label.modulate.a > 0:
		%round_label.modulate.a -= 0.01
		%fondu_label.start(0.001)
	else:
		is_start_label_done = true
		%fondu_label.start(3)

func _on_porte_dr_zen_body_entered(body):
	if body.has_method("player"):
		GlobalScript.apply_queue_debuff("DrZen")
		GlobalScript.change_map("res://scenes/maps/porte_medecin_DrZen.tscn")

func _on_porte_dr_droy_body_entered(body):
	if body.has_method("player"):
		GlobalScript.apply_queue_debuff("DrDroy")
		GlobalScript.change_map("res://scenes/maps/porte_medecin_DrDroy.tscn")

func _on_porte_dr_zim_zim_body_entered(body):
	if body.has_method("player"):
		GlobalScript.apply_queue_debuff("DrZimZim")
		GlobalScript.change_map("res://scenes/maps/porte_medecin_DrZimZim.tscn")

func _on_porte_dr_chirugien_body_entered(body):
	if body.has_method("player"):
		GlobalScript.apply_queue_debuff("DrChirurgien")
		GlobalScript.change_map("res://scenes/maps/porte_medecin_DrChirurgien.tscn")

func _on_porte_dr_psy_body_entered(body):
	if body.has_method("player"):
		GlobalScript.apply_queue_debuff("DrPsy")
		GlobalScript.change_map("res://scenes/maps/porte_medecin_DrPsy.tscn")

func _on_porte_dr_famille_body_entered(body):
	if body.has_method("player"):
		GlobalScript.apply_queue_debuff("DrFamille")
		GlobalScript.change_map("res://scenes/maps/porte_medecin_DrFamille.tscn")
