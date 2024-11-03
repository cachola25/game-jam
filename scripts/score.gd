extends Node2D

@onready var score
@onready var is_talking
@onready var out_of_time
@onready var deincrement_score
@onready var ate
@onready var drank
@onready var NPCs = [$boy_cousin, $brother, $uncle, $aunt, $dad, $girl_cousin, $grandma, $grandpa, $mom, $sister]
@onready var ate1 = false
@onready var ate2 = false
@onready var ate3 = false
@onready var drank1 = false
@onready var drank2 = false
@onready var drank3 = false
@onready var drank4 = false
signal consumed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 60
	deincrement_score = false
	is_talking = false
	out_of_time = false
	$DeincrementTimer.start()
	for npc in NPCs:
		npc.connect("check_if_talked_to_all", _on_check_if_talked_to_all)
	
func _process(delta: float) -> void:
	if not out_of_time and deincrement_score:
		score -= 1
		$Label.text = "Score: " + str(score)
		deincrement_score = false
	if is_talking:
		is_talking = false
		score += 60
	if score == 0:
		out_of_time = true
		get_tree().change_scene_to_file("res://scenes/EndScreen.tscn")

func _on_deincrement_timer_timeout() -> void:
	deincrement_score = true
	$DeincrementTimer.start()
	
func _on_main_character_talk() -> void:
	is_talking = true
	
func clear_indicators():
	for npc in NPCs:
		npc.get_node("indicator").visible = false

func _on_check_if_talked_to_all():
	for npc in NPCs:
		if not npc.talked_to:
			return
	var win_scene = preload('res://scenes/WinScreen.tscn')
	var win_scene_instance = win_scene.instantiate()
	win_scene_instance.get_node("Score").text = str(score)
	get_tree().get_root().add_child(win_scene_instance)
	get_tree().get_current_scene().queue_free()
	get_tree().set_current_scene(win_scene_instance)
	
func _on_drank_caneat() -> void:
	$ConsumeTimer.start()
	drank1 = true

func _on_drank_canteat() -> void:
	$ConsumeTimer.stop()
	drank1 = false


func _on_drank_2_caneat() -> void:
	$ConsumeTimer.start()
	drank2 = true
	
func _on_drank_2_canteat() -> void:
	$ConsumeTimer.stop()
	drank2 = false


func _on_consume_timer_timeout() -> void:
	score += 30
	if drank1:
		$Drank.queue_free()
	elif drank2:
		$Drank2.queue_free()
	elif drank3:
		$Drank3.queue_free()
	elif drank4:
		$Drank4.queue_free()
	elif ate1:
		$Drank5.queue_free()
	elif ate2:
		$Drank6.queue_free()
	elif ate3:
		$Drank7.queue_free()


func _on_drank_3_caneat() -> void:
	$ConsumeTimer.start()
	drank3 = true


func _on_drank_3_canteat() -> void:
	$ConsumeTimer.stop()
	drank3 = false


func _on_drank_4_caneat() -> void:
	$ConsumeTimer.start()
	drank4 = true


func _on_drank_4_canteat() -> void:
	$ConsumeTimer.stop()
	drank4 = false


func _on_drank_5_caneat() -> void:
	$ConsumeTimer.start()
	ate1 = true


func _on_drank_5_canteat() -> void:
	$ConsumeTimer.stop()
	ate1 = false


func _on_drank_6_caneat() -> void:
	$ConsumeTimer.start()
	ate2 = true


func _on_drank_6_canteat() -> void:
	$ConsumeTimer.stop()
	ate2 = false


func _on_drank_7_caneat() -> void:
	$ConsumeTimer.start()
	ate3 = true


func _on_drank_7_canteat() -> void:
	$ConsumeTimer.stop()
	ate3 = false
