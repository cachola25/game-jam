extends Node2D

signal done

@onready var response_options = [$response_1,$response_2,$response_3]

var messages = []

var typing_speed = .05
var read_time = 1.5

var current_message = 0
var display = ""
var current_char = 0

func _ready():
	visible = false
	for response in response_options:
		response.visible = false
	
func start_dialogue(dialogue):
	stop_dialogue()
	visible = true
	messages = dialogue
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	$talking/talking_message.text = ""
	$next_char.stop()
	$next_message.stop()

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$talking/talking_message.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		for response in response_options:
			response.visible = true
			response.get_node("select_arrow").visible = false
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()


func _on_response_1_button_mouse_entered() -> void:
	$response_1/select_arrow.visible = true


func _on_response_1_button_mouse_exited() -> void:
	$response_1/select_arrow.visible = false


func _on_response_2_button_mouse_entered() -> void:
	$response_2/select_arrow.visible = true


func _on_response_2_button_mouse_exited() -> void:
	$response_2/select_arrow.visible = false


func _on_response_3_button_mouse_entered() -> void:
	$response_3/select_arrow.visible = true


func _on_response_3_button_mouse_exited() -> void:
	$response_3/select_arrow.visible = false
