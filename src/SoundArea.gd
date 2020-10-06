extends Area2D


export(bool) var one_time = true
export(String) var sound = ""


func _on_SoundArea_body_entered(body):
	if body.name == "Player":
		play_sound()


func _on_SoundArea_area_entered(area):
	if area.owner.name == "Player":
		play_sound()

func play_sound():
	SfxController.play(sound)
	if one_time:
		queue_free()
