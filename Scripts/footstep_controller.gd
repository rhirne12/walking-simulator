class_name FootstepController
extends AudioStreamPlayer

@onready var body : CharacterBody3D = get_parent()

@export var sounds : Array[AudioStream]
@export var step_distance : float = 1.3
@export var pitch_variance : float = 0.2

var distance_traversed : float

func _process(delta: float) -> void:
	### If there is no body - such as can't find player character, simply return to avoid errors
	if not body: 
		return
	
	distance_traversed += body.velocity.length() * delta
	
	## are we standing on floor and traveled enough distance
	if body.is_on_floor() and distance_traversed >= step_distance:
		distance_traversed = 0.0
		stream = sounds.pick_random()
		pitch_scale = randf_range(1 - (pitch_variance / 2), 1 + (pitch_variance / 2))
		play()
		
