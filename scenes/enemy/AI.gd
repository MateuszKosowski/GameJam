extends Node
signal shoot(bulletPosition, bulletDirection)

enum State {
	PATROL, 
	ENGAGE
}

func _ready():
	var detect_zone = $PlayerDetectionZone
	
var state: int = State.PATROL
var player = null
var actor = null
var shootpt = null
var canShoot = true
var reloadTimer = null

func initialize(actor, shootpt, reloadTimer):
	self.actor = actor
	self.shootpt = shootpt
	self.reloadTimer = reloadTimer

func set_state(newstate: int):
	if newstate == state:
		return
	state = newstate

func _on_player_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body
	pass # Replace with function body.

func _process(delta):
	match state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null:
				actor.rotation = actor.position.angle_to_point(player.global_position) - deg_to_rad(90)
				if canShoot:
					var directToPlayer = shootpt.global_position.direction_to(player.global_position)				
					var selectedShootPos = shootpt.get_child(0)
					canShoot = false
					reloadTimer.start()
					shoot.emit(shootpt.global_position, directToPlayer)
		_:
			pass	


func _on_shoot_reload_timer_timeout():
	canShoot = true
	pass # Replace with function body.
