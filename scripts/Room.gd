class_name Room
extends map
@onready var animPlayer : AnimationPlayer = $rooms_anim
@onready  var cam : Camera2D = $Camera2D
@export var room_doc :  npc
# Called when the node enters the scene tree for the first time.
func _ready():
	self.focus_on_map.emit()
	
	var anim: Animation = animPlayer.get_animation("entering_room")
	
	var track_id : int = 0 
	var key_id: int = anim.track_find_key(track_id, 1.4)
	anim.track_set_key_value(track_id, key_id, $pos1.position)
	key_id = anim.track_find_key(track_id, 2.5)
	anim.track_set_key_value(track_id, key_id, $pos2.position)
	key_id = anim.track_find_key(track_id, 3.5)
	anim.track_set_key_value(track_id, key_id, $pos3.position)
	
	anim = animPlayer.get_animation("quit_room")
	key_id = anim.track_find_key(track_id,0)
	anim.track_set_key_value(track_id,key_id,$pos3.position)
	key_id = anim.track_find_key(track_id,0.7)
	anim.track_set_key_value(track_id,key_id,$pos2.position)
	key_id = anim.track_find_key(track_id,1.7)
	anim.track_set_key_value(track_id,key_id,$pos1.position)
	key_id = anim.track_find_key(track_id,2.5)
	anim.track_set_key_value(track_id,key_id,Vector2($exit_pos.position.x,$exit_pos.position.y-5))
	key_id = anim.track_find_key(track_id,3.1)
	anim.track_set_key_value(track_id,key_id,$exit_pos.position)
	
	
	animPlayer.play("entering_room")
	GlobalScript.interaction_finished.connect(_on_interaction_finished)

func _process(delta):
	var s = DisplayServer.window_get_size()
	cam.zoom.x = s.y/200
	cam.zoom.y = s.y/200
	
func _enter_tree():
	super._enter_tree()


func _on_interaction_finished():
	animPlayer.play("quit_room")

func exit_room():
	GlobalScript.next_round()



func interact():
	room_doc.interact()
