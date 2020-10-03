extends Node

onready var audio_sources_container = $Sources

const SFX_ROOT_PATH = "res://assets/Dropbox/Audio/Sound_Effect"

var clips = {
	"bullet": [
		preload("res://assets/Dropbox/Audio/Sound_Effect/Bullet/sound_effect_bullet_1.1.wav"),
		preload("res://assets/Dropbox/Audio/Sound_Effect/Bullet/sound_effect_bullet_1.2.wav"),
		preload("res://assets/Dropbox/Audio/Sound_Effect/Bullet/sound_effect_bullet_1.3.wav"),
		preload("res://assets/Dropbox/Audio/Sound_Effect/Bullet/sound_effect_bullet_1.4.wav"),
	],
	"dash": [
		preload("res://assets/Dropbox/Audio/Sound_Effect/Dash/sound_effect_dash_1.wav"),
	],
	"step": [
		preload("res://assets/Dropbox/Audio/Sound_Effect/Pace/sound_effect_pace_1.1.wav"),
		preload("res://assets/Dropbox/Audio/Sound_Effect/Pace/sound_effect_pace_1.2.wav"),
		preload("res://assets/Dropbox/Audio/Sound_Effect/Pace/sound_effect_pace_1.3.wav"),
		preload("res://assets/Dropbox/Audio/Sound_Effect/Pace/sound_effect_pace_1.4.wav"),
	]
}

var audio_sources = []

const MAX_AUDIO_SOURCES = 10

const MIN_PITCH = 0.85
const MAX_PITCH = 1.15
var rng = RandomNumberGenerator.new()

func _init() -> void:
	rng.randomize()

func play(name) -> void:
	if not name:
		return
	if name in clips:
		for s in audio_sources:
			if not s.playing:
				_play_audio(s, name)
				return
		if len(audio_sources) < MAX_AUDIO_SOURCES:
			var new_source = AudioStreamPlayer.new()
			audio_sources_container.add_child(new_source)
			audio_sources.append(new_source)
			_play_audio(new_source, name)
		else:
			print("HEY! Trying to play too many (More than %s) " \
				 + "audio clips at the same time" % MAX_AUDIO_SOURCES)
	else:
		print("HEY! No such audio clip: %s" %name)

func _play_audio(source, name):
	source.stream = clips[name][rng.randi_range(0, len(clips[name]) - 1)]
	source.pitch_scale = rng.randf_range(MIN_PITCH, MAX_PITCH)
	source.play()
