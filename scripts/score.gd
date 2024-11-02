extends Node2D

@onready var score
@onready var is_talking
@onready var out_of_time
@onready var deincrement_score
@onready var ate
@onready var drank
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
		print(score)
		deincrement_score = false
	if ate or drank or is_talking:
		ate = false
		drank = false
		is_talking = false
		score += 50


func _on_deincrement_timer_timeout() -> void:
	deincrement_score = true
	$DeincrementTimer.start()
	


func _on_main_character_talk() -> void:
	is_talking = true
