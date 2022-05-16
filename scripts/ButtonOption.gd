extends Button

func _on_ButtonOption_pressed():
	var scene = load("res://scene/Option.tscn")
	get_tree().change_scene_to(scene)
