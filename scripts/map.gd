class_name map
extends Node2D

@onready var top_right = $TopRight
@onready var bottom_left = $BottomLeft

func _ready():
	GlobalScript.current_map = self
	GlobalScript.current_map_top_right = top_right
	GlobalScript.current_map_bottom_left = bottom_left


