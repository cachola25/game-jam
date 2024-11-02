extends Node2D

@onready var score
@onready var is_talking
@onready var timer
@onready var out_of_time
@onready var deincrement_score
@onready var ate
@onready var drank
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 100
	deincrement_score = false
	is_talking = true
	out_of_time = false
	timer = $Timer
	ate = false
	drank = false
	$DeincrementTimer.start()
func _process(delta: float) -> void:
	if is_talking and not out_of_time and deincrement_score:
		score -= 1
		print(score)
		deincrement_score = false
	if ate or drank:
		score += 50


func _on_deincrement_timer_timeout() -> void:
	deincrement_score = true
	$DeincrementTimer.start()
	
