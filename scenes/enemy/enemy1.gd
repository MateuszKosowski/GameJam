extends CharacterBody2D
signal shoot(bulletPosition, bulletDirection)

func _ready():
	var ai = $AI
	var shootpt = $ShootPos
	var reloadTimer = $ShootReloadTimer
	ai.initialize(self, shootpt, reloadTimer)

var health := 100
var canShoot = true

func handle_hit():
	health -= 100
	if (health <= 0):
		queue_free()



func _on_ai_shoot(bulletPosition, bulletDirection):
	shoot.emit(bulletPosition, bulletDirection)
	pass # Replace with function body.
