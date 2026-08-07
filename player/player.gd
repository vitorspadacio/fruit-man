class_name Player extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED := 300.0
const JUMP_CANCEL_RATE := 0.5
const JUMP_VELOCITY := -400.0
const NEGATIVE_SPEED := 2000

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
 
	var direction := Input.get_axis("left", "right")
	
	# Change sprite direction
	if direction < 0:
		sprite_2d.flip_h = true 
	elif direction > 0:
		sprite_2d.flip_h = false 
	
	# Move the player
	if Input.is_action_just_pressed("up") and is_on_floor():
		animation_player.play("jump")
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("up") and not is_on_floor():
		velocity.y *= JUMP_CANCEL_RATE
		
	if direction:
		animation_player.play("run")
		velocity.x = direction * SPEED
	else:
		animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, NEGATIVE_SPEED * delta)
		
	if velocity.y > 0:
		animation_player.play("fall")

	move_and_slide()
