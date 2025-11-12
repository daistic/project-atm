class_name Player

extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 300.0
@export var jump_velocity: float = -625.0

var walk_direction: float

func _process(_delta: float) -> void:
	_handle_animations()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
	if Input.is_action_just_released("Jump") and not is_on_floor():
		velocity.y = 0.0
	
	walk_direction = Input.get_axis("Move Left", "Move Right")
	if walk_direction:
		velocity.x = walk_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()

func _handle_animations() -> void:
	if is_on_floor():
		if walk_direction == 0.0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("Walk")
			_handle_sprite_facing()
	
	else:
		animated_sprite_2d.play("Jump")
		_handle_sprite_facing()

func _handle_sprite_facing() -> void:
	if walk_direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif walk_direction == -1.0:
		animated_sprite_2d.flip_h = true
