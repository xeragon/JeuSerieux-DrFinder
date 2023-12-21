extends npc

func interact():
	DialogueManager.show_reserve_balloon(load("res://dialog/reservation_secretaire.dialogue"),"start")
