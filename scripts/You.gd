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
