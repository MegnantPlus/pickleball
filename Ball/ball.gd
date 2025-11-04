extends RigidBody2D

var speed = 300


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0
	
	var direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	linear_velocity = direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.name == "Pan":
		linear_velocity.x = - linear_velocity.x
