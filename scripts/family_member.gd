extends CharacterBody2D

class_name family_member

const SPEED = 100

func _ready() -> void:
	$AnimatedSprite2D.play("walking")
	# Delay the initial pathfinding to allow the navigation map to synchronize
	call_deferred("start_navigation")

func start_navigation():
	var randX = randf_range(0, get_viewport_rect().size.x)
	var randY = randf_range(0, get_viewport_rect().size.y)
	make_path(Vector2(randX, randY))

func _physics_process(delta: float) -> void:
	if $NavigationAgent2D.get_path():
		var next_path_position = $NavigationAgent2D.get_next_path_position()
		var direction = global_position.direction_to(next_path_position)
		var new_velocity = direction * SPEED
		set_velocity(new_velocity)
		move_and_slide()
	else:
		# No path available yet; stop movement
		set_velocity(Vector2.ZERO)
		move_and_slide()

func _on_navigation_agent_2d_navigation_finished() -> void:
	var randX = randf_range(0, get_viewport_rect().size.x)
	var randY = randf_range(0, get_viewport_rect().size.y)
	make_path(Vector2(randX, randY))

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = velocity.move_toward(safe_velocity, 100)

func make_path(position: Vector2):
	$NavigationAgent2D.set_target_position(position)
