extends Button

func _ready():
	pass # Replace with function body.
	
func _on_ButtonPlay_pressed():
	var scene = load("res://scene/JeuPrincipal.tscn")
	get_tree().change_scene_to(scene)
