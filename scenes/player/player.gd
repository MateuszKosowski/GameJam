extends CharacterBody2D

var canShoot: bool = true
var shootDirection: Vector2
#var looking_direction: bool = true
var charging_active: bool = false


signal shoot(bulletPosition, bulletDirection)

func _process(delta):
	
	
	#Player movement
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	position += direction * 200 * delta
	
	move_and_slide()
	
	#Player flip horizontally
	if direction.x < 0:
		$AnimatedSprite2D.play("facing_left")
	if direction.x > 0:
		$AnimatedSprite2D.play("default")
	
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
			
	if Input.is_action_pressed("charge") and !charging_active:
		print("charge")
		$ChargingTime.start()
		$".".set_process(false)
		$GPUParticles2D.emitting=true
		
		
		
# Reload canShoot
func _on_shoot_reload_timer_timeout():
	canShoot = true

func _on_charging_time_timeout():
	print("Charging Time over")
	$GPUParticles2D.emitting=false
	$".".set_process(true)
	get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 20, 1.5)
	$RadiusActiveTimer.start()
	

func _on_radius_active_timer_timeout():
	print("active timeout")
	get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 10, 1.5)
	charging_active=false
