class_name map
extends Node2D

signal focus_on_map

func _enter_tree():
	GlobalScript.current_map = self
