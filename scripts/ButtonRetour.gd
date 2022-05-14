extends Button

func _on_ButtonRetour_pressed():
	var scene = load("res://scene/MenuPrincipal.tscn")
	get_tree().change_scene_to(scene)
