extends Area2D

@export var speed: int = 350
var direction: Vector2 = Vector2.UP

func _process(delta):
	position += direction * speed * delta
