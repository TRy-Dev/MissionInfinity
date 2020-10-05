extends Node

onready var audio_player :AudioStreamPlayer = $AudioStreamPlayer
onready var anim_player :AnimationPlayer = $AnimationPlayer
onready var tween = $Tween

var songs = {
	"blueprint": preload("res://assets/Dropbox/Audio/Theme/theme_music_blueprint.ogg"),
	"menu": preload("res://assets/Dropbox/Audio/Theme/theme_music_menu.ogg"),
}

var muted = false

var base_volume_db = 0

const FADE_DURATION = 0.5

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
#	play_animation("fade_in")

func pause() -> void:
	if audio_player.playing:
		audio_player.stream_paused = true

func stop() -> void:
	audio_player.stop()
	audio_player.stream_paused = false

func set_volume_db(val: float, set_base=true) -> void:
	audio_player.volume_db = val
	if set_base:
		base_volume_db = val

func play_animation(name: String) -> void:
	if anim_player.has_animation(name):
		if name == "fade_in":
			tween_volume_db(base_volume_db)
		elif name == "fade_out":
			tween_volume_db(-80)
		else:
			anim_player.play(name)
	else:
		print("HEY! No such music animation: %s" %name)

func tween_volume_db(val):
	tween.stop_all()
	tween.interpolate_property(audio_player, "volume_db", audio_player.volume_db, val, FADE_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func toggle_muted():
	muted = !muted
	if muted:
		set_volume_db(-80, false)
	else:
		set_volume_db(base_volume_db, false)
		
