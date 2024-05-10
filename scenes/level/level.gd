extends Node2D

# Shooting
var bullet_scane: PackedScene = preload("res://scenes/bullet/bullet.tscn")
func _on_player_shoot(bulletPosition, bulletDirection):
	var bullet = bullet_scane.instantiate() as Area2D
	bullet.position = bulletPosition
	bullet.direction = bulletDirection
	$Bullets.add_child(bullet)
	$RemoveBullet.start()
	

func _on_remove_bullet_timeout():
	for n in $Bullets.get_children():
		$Bullets.remove_child(n)
		n.queue_free()


func _on_enemy_shoot(bulletPosition, bulletDirection):
	var bullet = bullet_scane.instantiate() as Area2D
	bullet.position = bulletPosition
	bullet.direction = bulletDirection
	bullet.target = "player"
	$Bullets.add_child(bullet)
	$RemoveBullet.start()
	pass # Replace with function body.
