extends CharacterBody2D

class_name family_member

signal chosen_response

const SPEED = 60

var talking = false  # Indicates whether the NPC is currently talking

func _ready() -> void:
	$AnimatedSprite2D.play("walking")
	$NavigationAgent2D.connect("navigation_finished", _on_navigation_agent_2d_navigation_finished)
	$NavigationAgent2D.connect("velocity_computed", _on_navigation_agent_2d_velocity_computed)
	$dialogue/response_1/response_button.connect("pressed", _on_response_1_button_pressed)
	$dialogue/response_2/response_button.connect("pressed", _on_response_2_button_pressed)
	# Delay the initial pathfinding to allow the navigation map to synchronize
	call_deferred("start_navigation")

func start_navigation():
	var randX = randf_range(0, get_viewport_rect().size.x)
	var randY = randf_range(0, get_viewport_rect().size.y)
	make_path(Vector2(randX, randY))

func _physics_process(delta: float) -> void:
	if talking:
		set_velocity(Vector2.ZERO)
		move_and_slide()
		return
	if $NavigationAgent2D.get_path():
		var next_path_position = $NavigationAgent2D.get_next_path_position()
		var direction = global_position.direction_to(next_path_position)
		var new_velocity = direction * SPEED
		set_velocity(new_velocity)
		move_and_slide()
	else:
		set_velocity(Vector2.ZERO)
		move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	if talking:
		velocity = Vector2.ZERO
	else:
		velocity = velocity.move_toward(safe_velocity, 100)

func _on_navigation_agent_2d_navigation_finished() -> void:
	if not talking:
		var randX = randf_range(0, get_viewport_rect().size.x)
		var randY = randf_range(0, get_viewport_rect().size.y)
		make_path(Vector2(randX, randY))

func make_path(position: Vector2):
	$NavigationAgent2D.set_target_position(position)
	
func _on_response_1_button_pressed():
	emit_signal("chosen_response", self, $dialogue/response_1/response_text.text)
func _on_response_2_button_pressed():
	emit_signal("chosen_response", self, $dialogue/response_2/response_text.text)
