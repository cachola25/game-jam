extends family_member

class_name aunt

var curr_message = 0
var messages = [
	[
		"Why do you always dress like you've rolled out of bed?"
	],
	[
		"Your cousin, Fiona, just bought a house; what exactly are you waiting for?",
		"Or are you planning on living in your parent's basement?"
	],
	[
		"Well... that's a smart way about it.",
		"You should still make more investments, they'll pay off later."
	],
	[
		"When are you going to grow up and stop acting like a child?"
	]
]

var player_responses = [
	[
		"Why are you dressed like that?",
		"Sorry, it's how I like to dress." 
	],
	[
		"I try to live frugally.",
		"I am trying manage my debt well."
	],
	[
		"*Leave Convo*"
	],
	[
		"Speaking of, how's your family?"
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
