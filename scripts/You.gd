extends CharacterBody2D

const SPEED = 100.0

var talking = false
var conversation_done = true

var global_family_npc
var collider
signal talk

func _ready() -> void:
	$player_dialogue.visible = false
	$player_dialogue.connect("done", _on_response_done)
	
func _process(delta: float) -> void:
	if talking:
		return
	var direction = Vector2.ZERO # (0,0d)

	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if direction.length() > 1:
		direction = direction.normalized()
				
	var collision_info = move_and_collide(direction * SPEED * delta)
	if collision_info and not talking:
		collider = collision_info.get_collider()
		
	if collider and Input.is_action_just_pressed("interact") and not talking:
		if not collider is family_member:
			return
		start_conversation(collider)
		talking = true
		conversation_done = false
		talk.emit()
		
func start_conversation(family_npc):
	velocity = Vector2.ZERO
	family_npc.talking = true
	family_npc.conversate()
	family_npc.connect("chosen_response", _on_player_response)
#
func _on_player_response(family_npc, response):
	var msg = []
	if family_npc is mom:
		mom_dialogue_options(family_npc, response, msg)
	elif family_npc is grandma:
		grandma_dialogue_options(family_npc, response, msg)
	elif family_npc is aunt:
		aunt_dialogue_options(family_npc, response, msg)
	elif family_npc is sister:
		sister_dialogue_options(family_npc, response, msg)
	elif family_npc is cousin_f:
		cousin_f_dialogue_options(family_npc, response, msg)
	elif family_npc is dad:
		dad_dialogue_options(family_npc, response, msg)
	elif family_npc is grandpa:
		grandpa_dialogue_options(family_npc, response, msg)
	elif family_npc is uncle:
		uncle_dialogue_options(family_npc, response, msg)
	elif family_npc is brother:
		brother_dialogue_options(family_npc, response, msg)
	elif family_npc is counsin_m:
		cousin_m_dialogue_options(family_npc, response, msg)
		
	family_npc.get_node("dialogue").visible = false
	$player_dialogue.visible = true
	$player_dialogue.curr_npc = family_npc
	$player_dialogue.start_dialogue(msg)
	
func _on_response_done(family_npc):
	global_family_npc = family_npc
	$response_timer.start()

func mom_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "I'm still looking for one.":
			msg.append("When I can find one in this economy that your generation ruined.")
		elif response == "My job pays well.":
			msg.append("To be fair, it pays more than yours.")
	elif family_npc.curr_message - 1 == 1:
		if response == "Why can't you be more like yours?":
			msg.append("Your sister doesn't complain as much as you do.")
			msg.append("Why can't you be more like yours?")
			family_npc.curr_message += 1
		elif response == "I'm just being myself.":
			msg.append("I'm sorry, I'm just being myself.")
			msg.append("But, I'm glad you both get along great.")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Mmhmm, goodbye")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Are you watching what you cook?":
			msg.append("Are you watching any cooking shows? You could really use some help in the kitchen")
			msg.append("At least I know how to cook something that I would want to eat.")
			conversation_done = true

func grandma_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "You're growing old, grandma.":
			msg.append("When will you meet your maker?")
		elif response == "I'm waiting for the right person.":
			msg.append("I'm just waiting for the right person")
	elif family_npc.curr_message - 1 == 1:
		if response == "Sorry grandma, I haven't had time.":
			msg.append("Sorry Grandma, I don't have the time to sit through a life lecture each time.")
			family_npc.curr_message += 1
		elif response == "Sorry grandma, life gets in the way.":
			msg.append("I'm sorry, grandma.")
			msg.append("I would but I've been too busy trying to start my life.")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Thanks, grandma. I'll try to call more.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Ask that to your daughter.":
			msg.append("Has your daughter ever learned how to cook?")
			msg.append("She could barely take care of me.")
			conversation_done = true
			
func aunt_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "Why are you dressed like that?":
			msg.append("Not sure, but why do you always dress like a goblin?")
		elif response == "Sorry, it's how I like to dress":
			msg.append("I dress how I would like to.")
			msg.append("I'm sorry if you think it's bad.")
	elif family_npc.curr_message - 1 == 1:
		if response == "I try to live frugally.":
			msg.append("I try to live well within my means.")
			msg.append("Unlike your child whose mouth runs just as much as their spending issues.")
			family_npc.curr_message += 1
		elif response == "I am trying manage my debt well.":
			msg.append("I am just trying to make sure I handle my debt before I take on more.")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Thanks, I'll try my best to keep budgeting.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Speaking of, how's your family?":
			msg.append("When will you actually raise your own kids?")
			msg.append("Instead of having your friends and husband do the work for you, ")
			msg.append("all so you can go and drink with your friends.")
			conversation_done = true

func sister_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "I'm making my own salary.":
			msg.append("Well, my salary doesn't come from mom and dad.")
			msg.append("It's from a real job.")
		elif response == "You must be a kind person.":
			msg.append("I'm sure it's because you're a kind person everyone would just love to hire you!")
	elif family_npc.curr_message - 1 == 1:
		if response == "Yeah, you're right...":
			msg.append("Yup, not a great failure like you.")
			family_npc.curr_message += 1
		elif response == "I think that's a good thing.":
			msg.append("I would gladly not end up to be whatever a \"great child\" is in your eyes.")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("And you can continue being a leech.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Working at NASA is pretty cool.":
			msg.append("If working for NASA isn't special, then shouldn't you ask yourself the same thing?")
			conversation_done = true
			
func cousin_f_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "Why would I be jealous?":
			msg.append("Jealous? Why would I be jealous of a walrus?")
		elif response == "Why would I admit that?":
			msg.append("If I was actually jealous, why would I ever admit to it?")
	elif family_npc.curr_message - 1 == 1:
		if response == "Don't think they say good things.":
			msg.append("You mean how they talk about how much of a bum you are?")
			family_npc.curr_message += 1
		elif response == "I don't need the attention.":
			msg.append("Feels great to be in the background.")
			msg.append("You should try it sometime.")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Nevermind, I guess you can't since walruses are hard to hide.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Don't you have veneers?":
			msg.append("I wouldn't be talking, I'm not the one whose teeth are fake.")
			conversation_done = true

func dad_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "Sorry, I always forget.":
			msg.append("Sometimes, I forget.")
			msg.append("Especially, when I am not at my own place.")
		elif response == "Yup, only at my place.":
			msg.append("I only do it at my place, I like spending your money.")
			msg.append("Just like my sister.")
	elif family_npc.curr_message - 1 == 1:
		if response == "When the economy improves.":
			msg.append("When the economy is not so terrible, hopefully.")
			family_npc.curr_message += 1
		elif response == "Don't you hate your job?":
			msg.append("When are you going to realize how unhappy you are at your \"good job\"")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("I'd rather be happy and poor than sad and rich.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Life is full of surprises.":
			msg.append("Life is always full of surprises, I am sure you're aware of that.")
			conversation_done = true
			
func grandpa_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "Nope, just trying to make it big.":
			msg.append("Nope, just trying to survive by investing my money.")
			msg.append("In DogeCoin and Day trading...")
		elif response == "Just trying to find a job.":
			msg.append("I wish, I've applied to 100 jobs.")
			msg.append("I ended up being ghosted by 80 and scammed by 20")
	elif family_npc.curr_message - 1 == 1:
		if response == "I'll be able to afford it soon.":
			msg.append("Don't worry, grandpa. I'll be able to afford it soon.")
			msg.append("Just don't write me out of your will.")
			family_npc.curr_message += 1
		elif response == "Everything is taken and expensive.":
			msg.append("I wish I was able to do this.")
			msg.append("Houses cost an arm and a leg and raising kids takes the head and shoulders.")
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Whatever grandpa, I'll see you next year.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Not now, grandpa...":
			msg.append("Get with the times, grandpa.")
			msg.append("I don't have time for this today, goodbye.")
			conversation_done = true

func uncle_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "I will never enlist.":
			msg.append("Sorry uncle, don't really feel like sacraficing my life for oil.")
		elif response == "I sure have...":
			msg.append("Yep, I defintely have.")
			msg.append("I'm definitely not lying through my teeth right now.")
	elif family_npc.curr_message - 1 == 1:
		if response == "Okay, I promse I'll enlist.":
			msg.append("Okay, fine. If it gets you off of my back. I'll enlist.")
			msg.append("(*whispers under my breath*) Just kidding lol.")
		elif response == "No matter how many times you ask...":
			msg.append("I just told you. You can ask one hundred more times and the answer is still NO")
			family_npc.curr_message += 1
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Aye, Aye Captain!")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Aren't you on bedrest?":
			msg.append("Are you even fit to go down the stairs?")
			msg.append("I want you 🫵🏻 to not get winded standing up.")
			conversation_done = true
			
func brother_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "It's all I had.":
			msg.append("Well, I didn't have any other shirt.")
			msg.append("Dad wouldn't let me use the washing machince since I leave the lights on.")
		elif response == "I actually really like this shirt.":
			msg.append("I didn't bother with your adivce.")
			msg.append("It's a shirt I like so I'm wearing it.")
	elif family_npc.curr_message - 1 == 1:
		if response == "Results just aren't showing.":
			msg.append("I have been going to the gym, you just can't tell.")
			msg.append("I hit personal records on squat and bench the other day.")
		elif response == "I don't care about the gym.":
			msg.append("I don't bother going to the gym.")
			msg.append("It's full of sweaty people and I don't want to get too bulky.")
			family_npc.curr_message += 1
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("Yeah, I'll keep trying build more muscle haha.")
			msg.append("(*whispers*) Can't believe he bought it.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "I have other things to worry about.":
			msg.append("I trying to survive with out the help of mom and dad.")
			msg.append("I have more important things to worry about other than whatever you and sister think.")
			conversation_done = true
			
func cousin_m_dialogue_options(family_npc, response, msg):
	if family_npc.curr_message - 1 == 0:
		if response == "I have, yes.":
			msg.append("I have, actually. They're pretty interesting.")
		elif response == "No, I don't have TikTok.":
			msg.append("No, I don't have TikTok. I think it consumes too much time.")
		msg.append("Either way, you're on that thing too much. I'm taking it.")
	elif family_npc.curr_message - 1 == 1:
		if response == "It's for your own good.":
			msg.append("Too much screen time can be bad for you.")
			msg.append("If you can go the whole dinner without your iPad, I'll buy you a new toy.")
		elif response == "You're too brainrotted.":
			msg.append("You probably have 24 hours of screen time.")
			msg.append("That's way too much, you definitely have brainrot.")
			family_npc.curr_message += 1
	elif family_npc.curr_message - 1 == 2:
		if response == "*Leave Convo*":
			msg.append("I promise to give it back, good job.")
			conversation_done = true
	elif family_npc.curr_message - 1 == 3:
		if response == "Whatever...":
			msg.append("Whatever, I don't like your mom anyways.")
			conversation_done = true
			
func finish_conversation(family_npc):
	talking = false
	family_npc.talking = false

func _on_response_timer_timeout() -> void:
	$player_dialogue.visible = false
	global_family_npc.get_node("dialogue").hide_response_options()
	
	if not conversation_done:
		global_family_npc.conversate()
	else:	
		finish_conversation(global_family_npc)
