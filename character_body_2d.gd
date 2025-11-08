extends CharacterBody2D

@onready var timer = $Timer
@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite2D

const SPEED = 300.0
const DASH_SPEED = 1000.0
const DASH_DURATION = 0.15

var is_dashing = false
var dash_direction = Vector2.ZERO
var can_dash = true
var normal_speed = SPEED

func _ready():
	collision_shape.disabled = true

func _physics_process(delta: float) -> void:
	handle_input()
	handle_movement()

func handle_input():
	var input_direction = Vector2.ZERO
	
	# Nhận input di chuyển
	if Input.is_action_pressed("pan_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("pan_right"):
		input_direction.x += 1
	if Input.is_action_pressed("pan_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("pan_down"):
		input_direction.y += 1
	
	# Chuẩn hóa vector để di chuyển chéo không nhanh hơn
	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()
	
	# Xử lý dash
	if Input.is_action_just_pressed("dash") and can_dash:
		if input_direction != Vector2.ZERO:
			# Dash theo hướng đang di chuyển
			start_dash(input_direction)
		else:
			# Dash về bên phải nếu không di chuyển
			start_dash(Vector2.RIGHT)
	
	# Áp dụng tốc độ
	if is_dashing:
		velocity = dash_direction * DASH_SPEED
	else:
		velocity = input_direction * normal_speed
	
	# Xử lý toggle collision
	if Input.is_action_just_pressed("col_off"):
		toggle_collision()

func start_dash(direction: Vector2):
	is_dashing = true
	can_dash = false
	dash_direction = direction
	
	# Tạo timer cho dash duration
	var dash_timer = get_tree().create_timer(DASH_DURATION)
	dash_timer.timeout.connect(_on_dash_timeout)
	
	# Cooldown cho dash tiếp theo
	var cooldown_timer = get_tree().create_timer(0.5)
	cooldown_timer.timeout.connect(_on_dash_cooldown_timeout)

func _on_dash_timeout():
	is_dashing = false

func _on_dash_cooldown_timeout():
	can_dash = true

func handle_movement():
	move_and_slide()

func toggle_collision():
	if timer.is_stopped():
		# Toggle collision state
		collision_shape.disabled = !collision_shape.disabled
		
		# Xoay sprite dựa trên trạng thái collision
		if collision_shape.disabled:
			sprite.rotation_degrees = 90
		else:
			sprite.rotation_degrees = 0
		
		# Bắt đầu timer để reset (nếu muốn tự động reset)
		timer.start()

func _on_timer_timeout():
	# Tự động reset về trạng thái ban đầu (tùy chọn)
	collision_shape.disabled = true
	sprite.rotation_degrees = 90
