extends npc


	
func interact():
	DialogueManager.show_tuto_balloon(load("res://dialog/Secretaire.dialogue"),"start")
