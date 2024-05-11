extends Node2D

func _on_button_no_pressed():
	#print("no")
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")

func _on_button_yes_pressed():
	#print("yes")
	get_tree().quit()
