class_name ToggleInteractable
extends Interactable

@export var node_to_toggle : Node3D
@export var start_state : bool = false
@export var toggle_on_prompt : String = "Turn On"
@export var toggle_off_prompt : String = "Turn Off"

@export_category("Sounds")
@export var audio_player : AudioStreamPlayer3D
@export var on_sfx : AudioStream
@export var off_sfx : AudioStream

func _ready() -> void:
	node_to_toggle.visible = start_state

func get_prompt() -> String:
	if node_to_toggle.visible:
		return toggle_off_prompt
	else:
		return toggle_on_prompt

func can_interact() -> bool:
	return true

func interact():
	node_to_toggle.visible = !node_to_toggle.visible
	
	### if on, play on sfx, else play off sfx
	if node_to_toggle.visible:
		_play_sound(on_sfx)
	else:
		_play_sound(off_sfx)
	
func _play_sound (sound : AudioStream):
	if not audio_player: return
	
	audio_player.stream = sound
	audio_player.play()
