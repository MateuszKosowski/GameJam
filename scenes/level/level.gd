extends Node2D

# Shooting
var bullet_scane: PackedScene = preload("res://scenes/bullet/bullet.tscn")
var bulletenemy_scane: PackedScene = preload("res://scenes/bullet/bulletenemy.tscn")
var nenemy_scane: PackedScene = preload("res://scenes/enemy/enemy1.tscn")
var player_scane: PackedScene = preload("res://scenes/player/player.tscn")
@export var player : Node2D

func _ready():
	$AudioStreamPlayer2D.play()

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

func _on_mob_spawner_spawn_mob(where, player_scane):
	var nenemy = nenemy_scane.instantiate() as CharacterBody2D
	nenemy.position = where
	nenemy.player = player_scane
	$Mobs.add_child(nenemy)
	pass # Replace with function body.




func _on_lantern_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_2_player_in_light(playr):
	player.in_light = true
	
	pass # Replace with function body.


func _on_lantern_3_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_4_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_5_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_6_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_7_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_8_player_in_light(playr):
	player.in_light = true
	pass # Replace with function body.


func _on_lantern_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_2_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_3_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_4_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_5_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_6_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_7_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.


func _on_lantern_8_player_out_light(playr):
	player.in_light = false
	pass # Replace with function body.
