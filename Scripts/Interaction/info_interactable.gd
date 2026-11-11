class_name InfoInteractable
extends Interactable

@export var prompt :String = "Inspect"
@export var info_to_display : String

@export_category("Sounds")
@export var audio_player : AudioStreamPlayer3D

func get_prompt() -> String:
	return prompt

func can_interact() -> bool:
	return true

func interact():
	get_tree().root.get_node("Main/InfoDisplayer").display(info_to_display)
	
	### if no audio is set or there is no audio player set, just return
	if not audio_player: 
		return
	
	audio_player.play()
	
