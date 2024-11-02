extends family_member

class_name cousin_f

var curr_message = 0
var messages = [
	[
		"Why don't you just admit that you're jealous of me?"
	],
	[
		"How does it feel like knowing that I'm the cousin everyone talks about?"
	],
	[
		"Maybe I will, freak.",
		"You're always giving me loner vibes anyways."
	],
	[
		"You know your bag is counterfeit right?",
		"Are you broke or have no taste?"
	],
]

var player_responses = [
	[
		"Why would I be jealous?",
		"Why would I admit that?" 
	],
	[
		"Don't think they say good things.",
		"I don't need the attention."
	],
	[
		"*Leave Convo*"
	],
	[
		"Don't you have veneers?"
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
