extends Node

enum State {
	PATROL, 
	ENGAGE
}

func _ready():
	var detect_zone = $PlayerDetectionZone
	
var state: int = State.PATROL
var player = null

func set_state(newstate: int):
	if newstate == state:
		return
	state = newstate
	emit_signal("state_changed", state)



func _on_player_detection_zone_body_entered(body):
	pass # Replace with function body.

	
