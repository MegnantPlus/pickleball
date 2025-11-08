extends CharacterBody2D

@onready var timer = $Timer
@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite2D

const SPEED = 300.0
const FIXED_Y = 400

var is_collision_enabled: bool = false

func _ready():
	position.y = FIXED_Y
	# Đảm bảo collision được bật từ đầu
	collision_shape.disabled = true

func _physics_process(delta: float) -> void:
	handle_input()
	handle_movement()
	position.y = FIXED_Y  # Giữ cố định vị trí Y

func handle_input():
	# Xử lý di chuyển trái/phải
	var direction = 0
	if Input.is_action_pressed("pan_left"):
		direction -= 1
	if Input.is_action_pressed("pan_right"):
		direction += 1
	
	velocity.x = direction * SPEED
	
	# Xử lý tắt/bật collision với nút col_off
	if Input.is_action_just_pressed("col_off"):
		toggle_collision()

func handle_movement():
	move_and_slide()

func toggle_collision():
	if timer.is_stopped():
		# Tắt collision và xoay sprite
		collision_shape.disabled = false
		sprite.rotation_degrees = 0
		
		# Bắt đầu timer để bật lại collision
		timer.start()

func _on_timer_timeout():
	# Bật lại collision và reset rotation
	collision_shape.disabled = true
	sprite.rotation_degrees = 90
