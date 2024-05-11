extends CharacterBody2D

const CHARGE_TIME = 2
var canShoot: bool = true
var shootDirection: Vector2
#var looking_direction: bool = true
var hp = 5
#var looking_direction: bool = true
var charging_active: bool = false
var chargetime = 2
var take_shadow_dmg = false
var in_light = false

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
	if $Camera2D/ReloadBar/TextureProgressBar.value == 100:
		$Camera2D/ReloadBar.visible = false
	else:
		$Camera2D/ReloadBar.visible = true
		
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
		$ReloadBarTimer.start()
		$Camera2D/ReloadBar/TextureProgressBar.value = 5
		shoot.emit(selectedShootPos.global_position, shootDirection)
			
	if Input.is_action_pressed("charge") and not charging_active:
		$ChargingTime.start()
		charging_active = true
		$GPUParticles2D.emitting=true
	if charging_active and (chargetime - $ChargingTime.time_left) > 0.33:
		chargetime -= 0.33
		$Camera2D/Progressbar/AnimatedSprite2D.frame += 1
	if $RadiusActiveTimer.is_stopped():
		get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 0, 15)
	else:
		get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 20, 1.5)
	if $PointLight2D2.get_texture_scale() <= 1.6 && $RadiusActiveTimer.is_stopped():
		get_tree().create_tween().tween_property($PointLight2D2,"texture_scale", 0, 0.1)
		if $DeathByShadowTimer.is_stopped() and !take_shadow_dmg:
			$DeathByShadowTimer.start()
			
	if take_shadow_dmg:
		resolve_dmg()
	print(in_light)
func resolve_dmg():
	if in_light:
		take_shadow_dmg = false
		return
	if not $ChargingTime.is_stopped():
		take_shadow_dmg = false
		return
	if not in_light:
		lose_hp()
		take_shadow_dmg = false

# Reload canShoot
func _on_shoot_reload_timer_timeout():
	canShoot = true
	$ReloadBarTimer.stop()
	
func handle_hit():
	if hp <= 0:
		pass
	lose_hp()

func _on_charging_time_timeout():
	print("Charging Time over")
	$GPUParticles2D.emitting=false
	charging_active = false
	$RadiusActiveTimer.start()
	$Camera2D/Progressbar/AnimatedSprite2D.frame = 0
	chargetime = CHARGE_TIME

func _on_radius_active_timer_timeout():
	print("active timeout")

func _on_death_by_shadow_timer_timeout():
	print("dbs timeout")
	take_shadow_dmg = true;

func lose_hp():
	hp -= 1
	if $Camera2D/UI/AnimatedSprite2D.frame == 4:
			get_tree().change_scene_to_file("res://scenes/deathscreen/deathscreen.tscn")
	
	$Camera2D/UI/AnimatedSprite2D.frame += 1	
	

func _on_reload_bar_timer_timeout():
	$Camera2D/ReloadBar/TextureProgressBar.value += 5
