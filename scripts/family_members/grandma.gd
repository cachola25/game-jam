extends family_member

class_name grandma

var curr_message = 0
var messages = [
	[
		"When will you find a partner, you're already 25?"
	],
	[
		"Why don't you call me more often?"
	],
	[
		"That makes sense, my darling.",
		"At least you are busy making a life for yourself instead of rotting away."
	],
	[
		"Are you ever going to learn how to cook?",
		"You need to learn how to take care of yourself."
	]
]

var player_responses = [
	[
		"You're growing old, grandma.",
		"I'm waiting for the right person." 
	],
	[
		"Sorry grandma, I haven't had time.",
		"Sorry grandma, life gets in the way."
	],
	[
		"*Leave Convo*"
	],
	[
		"Ask that to your daughter."
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
