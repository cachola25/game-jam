extends CharacterBody2D

const SPEED = 50
var messages = [
	"This is test dialogue, This is test dialogue", 
	"This is another message"
]

func _ready() -> void:
	$AnimatedSprite2D.play("walking")
	
func _process(delta: float) -> void:
	pass
	
	
