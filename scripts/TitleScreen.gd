extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TitleScreenMusic._playMusicLevel()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_help_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/HelpScreen.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()



func _on_start_button_pressed() -> void:
	TitleScreenMusic._stopMusicLevel()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
