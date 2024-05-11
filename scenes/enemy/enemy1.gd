extends CharacterBody2D
signal shoot(bulletPosition, bulletDirection)

func _ready():
	var ai = $AI
	var shootpt = $ShootPos
	var reloadTimer = $ShootReloadTimer
	var playerDetect = $PlayerDetectionZone
	playerDetect.initialize(self, shootpt, reloadTimer)

var health := 100
var canShoot = true

func handle_hit():
	health -= 100
	if (health <= 0):
		queue_free()

func _on_shoot_reload_timer_timeout():
	pass # Replace with function body.


func _on_player_detection_zone_shoot(bulletPosition, bulletDirection):
		shoot.emit(bulletPosition, bulletDirection)
