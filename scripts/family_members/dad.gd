extends family_member

class_name dad

var curr_message = 0
var messages = [
	[
		"Do you turn off the lights when you leave a room in your own place?",
		"Because you sure don't here."
	],
	[
		"When are you gonna be able to pay for everything yourself and get a good job?"
	],
	[
		"Well I would rather be sad and rich than poor like you."
	],
	[
		"Are your sure about your career choices?",
		"I would have never guessed my child would be doing what you do."
	],
]

var player_responses = [
	[
		"Sorry, I always forget.",
		"Yup, only at my place." 
	],
	[
		"When the economy improves.",
		"Don't you hate your job?"
	],
	[
		"*Leave Convo*"
	],
	[
		"Life is full of surprises."
	]
]

func conversate():
	if curr_message < messages.size():
		talking = true
		$dialogue.current_message_idx = curr_message
		$dialogue.start_dialogue(messages[curr_message])
		curr_message += 1
	else:
		talking = true
		curr_message = 0 
