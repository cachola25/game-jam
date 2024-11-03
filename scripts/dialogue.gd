extends Node2D

signal done

@onready var response_options = [$response_1, $response_2]
@onready var talking_message = $talking/talking_message

var messages = []
var typing_speed = 0.03
var read_time = 2.0

var current_message = 0
var display = ""
var current_char = 0
var current_message_idx

var max_lines = 3

func _ready():
	visible = false
	hide_response_options()
	
func hide_response_options():
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
	$next_char.stop()
	$next_message.stop()

func _on_next_char_timeout():
	if len(messages) <= 0:
		return
	if current_char < len(messages[current_message]):
		var next_char = messages[current_message][current_char]
		add_char(next_char)
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func add_char(char):
	display += char
	talking_message.text = display

	# Overflow handling based on line count
	while talking_message.get_line_count() > max_lines:
		var words = display.split(" ")
		if words.size() > 1:
			words.remove_at(0)
			display = " ".join(words)
		else:
			display = display.substr(1)
		talking_message.text = display

func _on_next_message_timeout():
	if len(messages) <= 0:
		return
	if current_message == len(messages) - 1:
		var options = get_parent().player_responses[current_message_idx]
		var index = 0
		for response in response_options:
			if index >= len(options):
				break
			response.visible = true
			response.get_node("response_text").text = options[index]
			response.get_node("select_arrow").visible = false
			index += 1
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
