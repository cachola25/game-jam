extends family_member

class_name grandpa

var curr_message = 0
var messages = [
	[
		"What are kids up to these days?",
		"Just fortnite and partying?"
	],
	[
		"Have you even bought a house yet?",
		"Or give me any great-grandchildren yet?"
	],
	[
		"Sounds like your generation lacks the work ethic we had.",
		"That's why the economy is going downhill nowadays."
	],
	[
		"Do you even watch Fox News or are you still blinded by liberal propaganda?"
	],
]

var player_responses = [
	[
		"Nope, just trying to make it big.",
		"Just trying to find a job." 
	],
	[
		"I'll be able to afford it soon.",
		"Everything is taken and expensive."
	],
	[
		"*Leave Convo*"
	],
	[
		"Not now, grandpa..."
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
