extends CharacterBody2D

const CHARGE_TIME = 2
var canShoot: bool = true
var shootDirection: Vector2
#var looking_direction: bool = true
var hp = 5
#var looking_direction: bool = true
var charging_active: bool = false
var chargetime = 2

signal shoot(bulletPosition, bulletDirection)

func _process(delta):
	
	
	#Player movement
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if charging_active: 
		direction = Vector2(0,0)
	position += direction * 200 * delta
	
	move_and_slide()
	
	#Player flip horizontally
	if direction.x < 0:
		$AnimatedSprite2D.play("facing_left")
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
	if Input.is_action_pressed("shootUp") and canShoot and !charging_active:
		shootDirection = Vector2.UP
	if Input.is_action_pressed("shootDown") and canShoot and !charging_active:
		shootDirection = Vector2.DOWN
	if Input.is_action_pressed("shootLeft") and canShoot and !charging_active:
		shootDirection = Vector2.LEFT
	if Input.is_action_pressed("shootRight") and canShoot and !charging_active:
		shootDirection = Vector2.RIGHT
	if Input.is_action_pressed("shootGeneral") and canShoot and !charging_active:
		var selectedShootPos = $ShootPos.get_child(0)
		canShoot = false
		$ShootReloadTimer.start()
		shoot.emit(selectedShootPos.global_position, shootDirection)
			
	if Input.is_action_pressed("charge") and not charging_active:
		$ChargingTime.start()
		charging_active = true
		$GPUParticles2D.emitting=true
	if charging_active and (chargetime - $ChargingTime.time_left) > 0.33:
		chargetime -= 0.33
		$Camera2D/Progressbar/AnimatedSprite2D.frame += 1
	print($RadiusActiveTimer.get_time_left())
	if $RadiusActiveTimer.is_stopped():
		get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 0, 20)
	else:
		get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 20, 1.5)
		
	if $PointLight2D2.get_texture_scale() <= 3:
		get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 0, 0.1)
		if $wDeathByShadowTimer.is_stopped():
			$DeathByShadowTimer.start()
			
			
# Reload canShoot
func _on_shoot_reload_timer_timeout():
	canShoot = true
	
func handle_hit():
	if hp <= 0:
		pass
	hp -= 1
	$Camera2D/UI/AnimatedSprite2D.frame += 1	

func _on_charging_time_timeout():
	print("Charging Time over")
	$GPUParticles2D.emitting=false
	charging_active = false
	$RadiusActiveTimer.start()
	$Camera2D/Progressbar/AnimatedSprite2D.frame = 0
	chargetime = CHARGE_TIME
	
	

func _on_radius_active_timer_timeout():
	print("active timeout")
