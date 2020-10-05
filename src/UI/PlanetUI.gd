extends Control

func _on_pressed():
	SfxController.play("ui-click")
	owner.start_game()
