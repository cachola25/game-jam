extends family_member

class_name uncle

var curr_message = 0
var messages = [
	[
		"Hey kid, have you enlisted in the army yet?",
		"Don't tell me you're like your dad and not enlisting?"
	],
	[
		"You better enlist.",
		"The army will teach you things you can't learn in a cushy office job."
	],
	[
		"Sounds good, because I want you 🫵🏻 to fight for our country."
	],
	[
		"Always knew you didn't have what it takes.",
		"Your generation will be end of this great country."
	],
]

var player_responses = [
	[
		"I will never enlist.",
		"I sure have..." 
	],
	[
		"Okay, I promse I'll enlist.",
		"No matter how many times you ask..."
	],
	[
		"*Leave Convo*"
	],
	[
		"Aren't you on bedrest?"
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
