extends CharacterBody3D

@export var walk_speed : float = 3.0
@export var run_speed_modifier : float = 1.5

@export var acceleration : float = 10.0
@export var braking : float = 10.0

@export var jump_force : float = 7.0
@export var gravity : float = -20.0

@export var look_sensitivity : float = 0.3
@export var look_min_rot : float = -85.0
@export var look_max_rot : float = 85.0

@onready var camera : Camera3D = $Camera3D

func _ready() -> void:
	## have mouse disappear in our play window
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	### Get Inputs
	var move_input : Vector2 = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	var run_input : bool = Input.is_action_pressed("run")
	var jump_input : bool = Input.is_action_pressed("jump")
	
	### Gravity and jumping
	## Are we standing on the floor
	if is_on_floor():
		velocity.y = -2.0
		
		## have we pressed the jump button
		if jump_input:
			velocity.y = jump_force
	else:
		velocity.y += gravity * delta
	
	## Movement
	var target_vel : Vector3 = Vector3.ZERO	
	var target_rate : float = acceleration if move_input.length() > 0 else braking
	
	## Have we pressed a movement direction
	if move_input.length() > 0:
		target_vel = Vector3(move_input.x, 0, move_input.y) * walk_speed
		
		if run_input:
			target_vel *= run_speed_modifier
	
	## get camera forward and right direction
	var cam_forward : Vector3 = -camera.basis.z
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()
	var cam_right : Vector3 = camera.basis.x
	
	var relative_target_vel : Vector3 = (target_vel.x * cam_right) + (target_vel.z * cam_forward)
	
	velocity.x = lerpf(velocity.x, relative_target_vel.x, target_rate * delta)
	velocity.z = lerpf(velocity.z, relative_target_vel.z, target_rate * delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#  Yaw rotation - left and right
		#  camera is inverted so we subtract
		camera.rotation_degrees.y -= event.relative.x * look_sensitivity
		
		# Pitch rotation - up and down
		# camera is inverted so we subtract also
		camera.rotation_degrees.x -= event.relative.y * look_sensitivity
		camera.rotation_degrees.x = clampf(camera.rotation_degrees.x, look_min_rot, look_max_rot)
