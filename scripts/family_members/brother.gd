
extends family_member

class_name brother

var curr_message = 0
var messages = [
	[
		"I thought I told you not to wear that shirt.",
		"You should really listen to my fashion tips."
	],
	[
		"Haven't I told you to hit the gym too?",
		"It looks like you've only been training to slight discomfort instead of failure."
	],
	[
		"As long as your strength is still good.",
		"You should really listen to me more often"
	],
	[
		"See, this is why sister is my favorite sibling.",
		"She actually listens to the useful advice I have."
	],
]

var player_responses = [
	[
		"It's all I had.",
		"I actually really like this shirt." 
	],
	[
		"Results just aren't showing.",
		"I don't care about the gym."
	],
	[
		"*Leave Convo*"
	],
	[
		"I have other things to worry about."
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
