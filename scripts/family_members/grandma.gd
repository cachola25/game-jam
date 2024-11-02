extends family_member

class_name grandma

var curr_message = 0
var messages = [
	[
		"When are you going to get a real job?"
	],
	[
		"You know your sister would never talk to me like that?",
		"Why can't you be more like her?"
	],
	[
		"Are you watching what you eat?",
		"You look like you're letting yourself go."
	]
]

var player_responses = [
	[
		"I'm still looking for one.",
		"My job pays well." 
	],
	[
		"Why can't you be more like yours?",
		"I'm just being myself."
	],
	[
		"Are you watching what you cook?"
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
