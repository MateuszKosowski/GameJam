extends Node2D

signal spawnMob(where, player)
@export var player: Node2D

func _process(delta):
	if $Timer.is_stopped():
		if randi()%5 == 0:
			$Timer.start()

func _on_timer_timeout():
	spawnMob.emit(self.position, player)
