extends Node2D
signal caneat
signal canteat
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Highlighted.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("_on_player_response"):
		$Unhighlighted.hide()
		$Highlighted.show()
		caneat.emit()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("_on_player_response"):
		$Unhighlighted.show()
		$Highlighted.hide()
		canteat.emit()


func _on_main_consumed() -> void:
	#queue_free()
	pass
