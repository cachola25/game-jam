extends family_member

class_name sister

var curr_message = 0
var messages = [
	[
		"How come you're not as successful as me?",
		"What are you doing wrong?"
	],
	[
		"You know, you will never end up being a great child like me."
	],
	[
		"Well, I guess you can just continue being a loser, idiot."
	],
	[
		"Why can't you get a clue and realize you're not as special as you think?"
	],
]

var player_responses = [
	[
		"I'm making my own salary.",
		"You must be a kind person." 
	],
	[
		"Yeah, you're right...",
		"I think that's a good thing."
	],
	[
		"*Leave Convo*"
	],
	[
		"Working at NASA is pretty cool."
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
