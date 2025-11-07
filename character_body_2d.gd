extends CharacterBody2D

@onready var time = $Timer
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var fixed_y = 600
@onready var col = $CollisionShape2D
@onready var pic = $Sprite2D
func _ready():
	position.y = fixed_y

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("pan_left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("pan_right"):
		velocity.x += SPEED
	if Input.is_action_pressed("col_off"):
		pic.rotation = 90
		col.disabled = false
		time.start()
		await time.timeout
		pic.rotation = 0	
		col.disabled = true
	move_and_slide()
	position.y = fixed_y


func _on_timer_timeout() -> void:
	pass # Replace with function body.
