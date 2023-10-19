class_name Player

extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var emote = $emote
@onready var interact_latency_timer = $interact_latency

@export var move_speed : int
var direction : Vector2
var move_direction : String = "down"
var interacting = false
var body_in_interact_range = null
@export var friction = 300

@onready var stress = $player_hud/ui/stress_bar
@onready var sante = $player_hud/ui/health_bar
@onready var player_hud = $player_hud


func _ready():
	GlobalScript.player_name = "alex"
	GlobalScript.player = self
	emote.visible = false
	

func _physics_process(delta):
	if not interacting:
		$player_hud.visible = false
		if body_in_interact_range and Input.is_action_just_pressed("ui_interact"):
			interacting = true
			body_in_interact_range.interact()
			
		if Input.is_action_pressed("ui_right"):
			move_direction = "right"
		elif Input.is_action_pressed("ui_left"):
			move_direction = "left"
		elif Input.is_action_pressed("ui_up"):
			move_direction = "up"
		elif Input.is_action_pressed("ui_down"):
			move_direction = "down"
		
		if velocity == Vector2(0,0):
			animate(false)
		else:
			animate(true)

		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
		
		if direction.length() > 0:
			velocity = direction * move_speed
		else:
			var deceleration = friction * delta 
			velocity = velocity.move_toward(Vector2(0, 0), deceleration)
		move_and_slide()
	else:
		$player_hud.visible = true
		animate(false)
		

	

func animate(isMoving : bool):
	var anim_state: String 
	if isMoving:
		anim_state = "run"
	else:
		anim_state= "idle"
		
	anim.play(anim_state+"_"+move_direction)


func player():
	pass
	
	
func _on_area_2d_body_entered(body):
	if body.has_method("interact"):
		body_in_interact_range = body


func _on_area_2d_body_exited(body):
	if body == body_in_interact_range:
		body_in_interact_range = null 


func _on_emote_animation_finished():
	emote.visible = false


func _on_interact_latency_timeout():
	interacting = false
