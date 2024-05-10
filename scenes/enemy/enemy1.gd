extends CharacterBody2D

func _ready():
	var ai = $AI
	
var health := 100

func handle_hit():
	health -= 100
	if (health <= 0):
		queue_free()
