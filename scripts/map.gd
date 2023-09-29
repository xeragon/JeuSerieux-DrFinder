class_name map
extends Node2D

func _ready():
	GlobalScript.current_map = self
	GlobalScript.hud = $DialogHud
	
