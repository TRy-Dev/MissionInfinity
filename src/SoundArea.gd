extends Area2D


export(bool) var one_time = true
export(String) var sound = ""


func _on_SoundArea_body_entered(body):
	play_sound()


func _on_SoundArea_area_entered(area):
	play_sound()

func play_sound():
	SfxController.play(sound)
	if one_time:
		queue_free()
