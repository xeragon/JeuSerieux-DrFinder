extends npc
func interact():
	DialogueManager.show_example_dialogue_balloon(load("res://dialog/DrZen.dialogue"),"start")

