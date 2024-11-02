extends CharacterBody2D

const SPEED = 300.0

func _process(delta: float) -> void:
		
	var direction = Vector2.ZERO # (0,0d)

	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if direction.length() > 1:
		direction = direction.normalized()
				
	var collision_info = move_and_collide(direction * SPEED * delta)
	if collision_info:
		var collider = collision_info.get_collider()
