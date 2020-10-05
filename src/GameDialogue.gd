extends Node

var dialogues = [
	"Hello Number 8.\nOnce again we need your help. Alien scum is spreading througout the galaxy and you are our only chance to survive.\nClick on the infested planet to start the mission whenever you are ready.\nGodspeed.",
	"Completing missions unlocks new weapons. Select weapon for the mission and click on planet whenever you are ready.",
	"We are getting closer to the core.\nExpect strong resistance.",
	"At last! This is our chance.\nYou must destroy the time machine before they use it!",
]

var current_idx = 0

func get_current_dialogue():
	return dialogues[current_idx]

func next_dialogue():
	current_idx = (current_idx + 1) % len(dialogues)
