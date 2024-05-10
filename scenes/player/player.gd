extends CharacterBody2D

func _process(delta):
	#Player movement
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	position += direction * 500 * delta
