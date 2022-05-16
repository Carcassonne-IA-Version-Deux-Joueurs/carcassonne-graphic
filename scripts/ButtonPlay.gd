extends Button
	
func _on_ButtonPlay_pressed():
	var scene = load("res://scene/JeuPrincipal.tscn")
	get_tree().change_scene_to(scene)
