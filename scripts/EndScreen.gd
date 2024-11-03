extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SadSound.play()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	#On restart button pressed, go to home screen
	get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")

func _on_quit_button_pressed() -> void:
	#On quit button pressed, quit
	get_tree().quit()
