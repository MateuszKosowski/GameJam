extends CharacterBody2D

var canShoot: bool = true
var shootDirection: Vector2
var looking_direction: bool = true

signal shoot(bulletPosition, bulletDirection)

func _process(delta):
	
	move_and_slide()
	#Player movement
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	position += direction * 200 * delta
	
	#Player flip horizontally
	if direction.x < 0:
		$AnimatedSprite2D.play("facing_left")
		#looking_direction = true
	if direction.x > 0:
		$AnimatedSprite2D.play("default")
		#looking_direction = false
	#$AnimatedSprite2D.flip_h=looking_direction
	
	#if Input.is_action_pressed("shootRight") and canShoot and Input.is_action_pressed("moveLeft"):
		#shootDirection = Vector2.RIGHT
		#print("komplikacja")
		
		#$AnimatedSprite2D.play("default")
		#$AnimatedSprite2D.animation_looped
	
	
	
	
	#Player shooting
	if Input.is_action_pressed("shootUp") and canShoot:
		shootDirection = Vector2.UP
	if Input.is_action_pressed("shootDown") and canShoot:
		shootDirection = Vector2.DOWN
	if Input.is_action_pressed("shootLeft") and canShoot:
		#if Input.is_action_pressed("moveRight"):
			#$ShootingInOposingDirectionTImer.start()
			#$AnimatedSprite2D.play("facing_left")
			#if $AnimatedSprite2D. != "facing_left":
				#$AnimatedSprite2D.play("facing_left")
			#else:
				#$AnimatedSprite2D.stop()
				
			#$AnimatedSprite2D.animation_looped
			#$AnimatedSprite2D.loop=true
			#$ShootingInOposingDirectionTImer.is_stopped()
			#print("biegnie w prawo, strzela w lewo")
		#else:
			#$AnimatedSprite2D.stop()
			#$AnimatedSprite2D.flip_h= true
		shootDirection = Vector2.LEFT
	if Input.is_action_pressed("shootRight") and canShoot:
		#if Input.is_action_pressed("moveLeft"):
			#$AnimatedSprite2D.play("default")
		#if looking_direction == true:
			#print("biegnie w lewo, strzela w prawo")
			#$AnimatedSprite2D.flip_h= true
		shootDirection = Vector2.RIGHT
		
	if Input.is_action_pressed("shootGeneral") and canShoot:
		var selectedShootPos = $ShootPos.get_child(0)
		canShoot = false
		$ShootReloadTimer.start()
		shoot.emit(selectedShootPos.global_position, shootDirection)

# Reload canShoot
func _on_shoot_reload_timer_timeout():
	canShoot = true
