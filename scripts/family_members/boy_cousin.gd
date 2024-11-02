extends family_member

class_name counsin_m

var curr_message = 0
var messages = [
	[
		"Have you seen the new TikTok trends?!"
	],
	[
		"Wait...",
		"NO!",
		"Why are you going to take away my iPad???"
	],
	[
		"Okay fine, but I want it back later."
	],
	[
		"I HATE YOU!!",
		"I'M TELLING MY MOM!"
	],
]

var player_responses = [
	[
		"I have, yes.",
		"No, I don't have TikTok." 
	],
	[
		"It's for your own good.",
		"You're too brainrotted."
	],
	[
		"*Leave Convo*"
	],
	[
		"Whatever..."
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
