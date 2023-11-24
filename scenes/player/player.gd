class_name Player
extends CharacterBody2D

enum State {IDLE ,MOVE,SIT}
enum MoveDirection {DOWN,UP,RIGHT,LEFT}
@onready var camera = $Camera2D
@onready var anim = $AnimatedSprite2D
@onready var emote = $emote
@onready var interact_latency_timer = $interact_latency
@export var move_speed : int
@export var interacting = false
@export var is_sitting : bool = false
@export var state : State = State.IDLE 
@export var move_direction : MoveDirection = MoveDirection.DOWN
var direction : Vector2
var body_in_interact_range = null
@export var friction = 300
@export var cutscene = false
@onready var stress = $player_hud/ui/stress_bar
@onready var sante = $player_hud/ui/health_bar
@onready var player_hud = $player_hud


func _ready():
	GlobalScript.player_name = "alex"
	GlobalScript.player = self
	GlobalScript.load_player_stats()
	emote.visible = false
	$player_hud.visible = true
	GlobalScript.interaction_finished.connect(_on_interaction_finished)
	
	GlobalScript.current_map.focus_on_map.connect(_on_focus_on_map_received)
	
	camera.enabled = true

	
func _physics_process(delta):
	if not interacting:
		if body_in_interact_range and Input.is_action_just_pressed("ui_interact"):
			interacting = true
			body_in_interact_range.interact()
			
		if Input.is_action_pressed("ui_right"):
			move_direction = MoveDirection.RIGHT
		elif Input.is_action_pressed("ui_left"):
			move_direction = MoveDirection.LEFT
		elif Input.is_action_pressed("ui_up"):
			move_direction = MoveDirection.UP
		elif Input.is_action_pressed("ui_down"):
			move_direction = MoveDirection.DOWN
		
		if not (velocity == Vector2(0,0)):
			animate(State.MOVE)
		else:
			animate(State.IDLE)
			
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
		
		if direction.length() > 0:
			velocity = direction * move_speed
			state = State.MOVE
		else:
			var deceleration = friction * delta 
			velocity = velocity.move_toward(Vector2(0, 0), deceleration)
			state = State.IDLE
		move_and_slide()
		
	if is_sitting:
		state = State.SIT
		
	animate(state)
	
func animate(state : State):
	var string_state: String 
	var string_move_direction : String;
	
	if state == State.MOVE:
		string_state = "run"
	elif state == State.IDLE:
		string_state= "idle"
	else:
		string_state = "sit"
	
	if move_direction == MoveDirection.RIGHT:
		string_move_direction = "right"
	elif move_direction == MoveDirection.LEFT:
		string_move_direction = "left"
	elif move_direction == MoveDirection.UP:
		string_move_direction = "up"
	else:
		string_move_direction = "down"
		
	anim.play(string_state+"_"+string_move_direction)
	
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

func _on_focus_on_map_received():
	camera.enabled = false
	
func _on_interaction_finished():
	#interact_latency_timer.start()
	pass
