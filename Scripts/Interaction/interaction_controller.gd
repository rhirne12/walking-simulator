extends RayCast3D

var current_interactable : Interactable
@onready var prompt_label : Label = $CanvasLayer/InteractPromptLabel

func _process(delta: float) -> void:
	var hit = get_collider()
	current_interactable = null
	
	if hit != null and hit is Interactable:
		if hit.can_interact():
			current_interactable = hit
	
	_update_prompt_label()
	
	if Input.is_action_just_pressed("interact") and current_interactable != null:
		current_interactable.interact()

func _update_prompt_label ():
	if current_interactable != null:
		prompt_label.text = "[E] %s" % current_interactable.get_prompt()
	else:
		prompt_label.text = ""
