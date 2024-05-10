extends Area2D

@export var speed: int = 350
var direction: Vector2 = Vector2.UP
var target = "enemy"

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):	
	if body.has_method("handle_hit") and body.is_in_group(target):
		body.handle_hit()
