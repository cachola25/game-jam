extends Node2D

signal done

@onready var talking_message = $talking/talking_message

var messages = []
var typing_speed = .03
var read_time = 2.0

var current_message = 0
var display = ""
var current_char = 0
var current_message_idx
var curr_npc

var max_lines = 4

func _ready():
	visible = false
	
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
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		add_char(next_char)
		current_char += 1
	else:
		$next_char.stop()
		if (current_message == len(messages) - 1):
			emit_signal("done",curr_npc)
		else:
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
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()
