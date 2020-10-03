extends Node

onready var audio_player :AudioStreamPlayer = $AudioStreamPlayer
onready var anim_player :AnimationPlayer = $AnimationPlayer

var songs = {
	"blueprint": preload("res://assets/Dropbox/Audio/Theme/theme_music_blueprint.ogg"),
}

func play(name :String = "") -> void:
	if name in songs:
		audio_player.stream = songs[name]
		_play()
	elif audio_player.stream_paused:
		audio_player.stream_paused = false
	elif name == "":
		_play()
	else:
		print("HEY! No such song: %s" % name)

func _play() -> void:
	audio_player.play()
	play_animation("fade_in")

func pause() -> void:
	if audio_player.playing:
		audio_player.stream_paused = true

func stop() -> void:
	audio_player.stop()
	audio_player.stream_paused = false

func set_volume_db(val: float) -> void:
	audio_player.volume_db = val

func play_animation(name: String) -> void:
	if anim_player.has_animation(name):
		anim_player.play(name)
	else:
		print("HEY! No such music animation: %s" %name)
