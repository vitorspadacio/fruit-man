extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const NEGATIVE_SPEED = 2000

func player_animations(direction):
		if Input.is_action_just_pressed("left"):
			sprite_2d.flip_h = true 
		if Input.is_action_just_pressed("right"):
			sprite_2d.flip_h = false 

		if is_on_floor():
			if direction != 0:
				animation_player.play("run")
			if direction == 0:
				animation_player.play("idle")
	
		elif velocity.y < 0:
			animation_player.play("jump")
		elif velocity.y > 0:
			animation_player.play("fall")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print(JUMP_VELOCITY);

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	player_animations(direction)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, NEGATIVE_SPEED * delta)


	move_and_slide()
