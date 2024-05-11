extends Node2D

# Shooting
var bullet_scane: PackedScene = preload("res://scenes/bullet/bullet.tscn")
var bulletenemy_scane: PackedScene = preload("res://scenes/bullet/bulletenemy.tscn")
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
	var bulletenemy = bulletenemy_scane.instantiate() as Area2D
	bulletenemy.position = bulletPosition
	bulletenemy.direction = bulletDirection
	bulletenemy.target = "player"
	bulletenemy.speed = 500
	$Bullets.add_child(bulletenemy)
	$RemoveBullet.wait_time = 2.0
	$RemoveBullet.start()
