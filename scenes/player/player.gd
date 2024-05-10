extends CharacterBody2D

var canShoot: bool = true
var shootDirection: Vector2
signal shoot(bulletPosition, bulletDirection)

func _process(delta):
	
	#Player movement
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	position += direction * 500 * delta
	
	#Player flip horizontally
	var isLeft = direction.x < 0
	$AnimatedSprite2D.flip_h=isLeft
	
	#Player shooting
	if Input.is_action_pressed("shootUp") and canShoot:
		shootDirection = Vector2.UP
	if Input.is_action_pressed("shootDown") and canShoot:
		shootDirection = Vector2.DOWN
	if Input.is_action_pressed("shootLeft") and canShoot:
		shootDirection = Vector2.LEFT
	if Input.is_action_pressed("shootRight") and canShoot:
		shootDirection = Vector2.RIGHT
	if Input.is_action_pressed("shootGeneral") and canShoot:
		var selectedShootPos = $ShootPos.get_child(0)
		canShoot = false
		$ShootReloadTimer.start()
		shoot.emit(selectedShootPos.global_position, shootDirection)

# Reload canShoot
func _on_shoot_reload_timer_timeout():
	canShoot = true
