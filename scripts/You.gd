extends CharacterBody2D

const SPEED = 300.0

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
