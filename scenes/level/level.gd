extends Node2D

# Shooting
var bullet_scane: PackedScene = preload("res://scenes/bullet/bullet.tscn")
func _on_player_shoot(bulletPosition, bulletDirection):
	var bullet = bullet_scane.instantiate() as Area2D
	bullet.position = bulletPosition
	bullet.direction = bulletDirection
	$Bullets.add_child(bullet)
