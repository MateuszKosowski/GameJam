extends CharacterBody2D
signal shoot(bulletPosition, bulletDirection)


@export var player: Node2D
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	#var ai = $AI
	var shootpt = $ShootPos
	var reloadTimer = $ShootReloadTimer
	var playerDetect = $PlayerDetectionZone
	playerDetect.initialize(self, shootpt, reloadTimer)

var health := 100
var canShoot = true
var speed = 100

func _physics_process(delta: float) ->void:
	var nextPathPos := navAgent.get_next_path_position()
	var dir := global_position.direction_to(nextPathPos)
	velocity = dir * speed
	move_and_slide()

func make_path() -> void:
	navAgent.target_position = player.global_position

func handle_hit():
	health -= 100
	if (health <= 0):
		queue_free()

func _on_shoot_reload_timer_timeout():
	pass # Replace with function body.


func _on_player_detection_zone_shoot(bulletPosition, bulletDirection):
		shoot.emit(bulletPosition, bulletDirection)
		$AudioStreamPlayer2D.play()


func _on_pathfinding_timer_timeout():
	make_path()
