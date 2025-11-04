extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var fixed_y = 600

func _ready():
	position.y = fixed_y

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("pan_left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("pan_right"):
		velocity.x += SPEED
	move_and_slide()
	position.y = fixed_y
