extends Node2D

@onready var score
@onready var is_talking
@onready var out_of_time
@onready var deincrement_score
@onready var ate
@onready var drank
@onready var NPCs = [$boy_cousin, $brother, $uncle, $aunt, $dad, $girl_cousin, $grandma, $grandpa, $mom, $sister]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 60
	deincrement_score = false
	is_talking = false
	out_of_time = false
	ate = false
	drank = false
	$DeincrementTimer.start()
func _process(delta: float) -> void:
	if not out_of_time and deincrement_score:
		score -= 1
		$Label.text = str(score)
		deincrement_score = false
	if ate or drank or is_talking:
		ate = false
		drank = false
		is_talking = false
		score += 50
		
	if score == 0:
		get_tree().change_scene_to_file("res://scenes/EndScreen.tscn")


func _on_deincrement_timer_timeout() -> void:
	deincrement_score = true
	$DeincrementTimer.start()
	
func _on_main_character_talk() -> void:
	is_talking = true
	
func clear_indicators():
	for npc in NPCs:
		npc.get_node("indicator").visible = false
