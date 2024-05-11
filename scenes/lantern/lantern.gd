extends Node2D

var active:bool = true
var playerin: bool = false

func _process(delta):
	if active:
		$PointLight2D.set_enabled(true)
		if playerin and $TimerOn.is_stopped():
			$TimerOn.start()
	if !active:
		$PointLight2D.set_enabled(false)

func _ready():
	var zone = $PlayerDetect
	var zonecolider = $PlayerDetect/PlayerDetectColider

func _on_player_detect_body_entered(body):
	if body.is_in_group("player"):
		playerin = true

func _on_timer_off_timeout():
	active = true

func _on_timer_on_timeout():
	active = false
	$TimerOff.start()

func _on_player_detect_body_exited(body):
	if(body.is_in_group("player")):
		playerin = false
