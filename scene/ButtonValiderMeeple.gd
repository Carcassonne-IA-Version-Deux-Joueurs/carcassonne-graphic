extends Button

func _ready():
	var position_parent = get_parent().get_child(0).position
	set_position(Vector2(position_parent.x, position_parent.y + 30))
	pass

func _on_ButtonValiderMeeple_pressed():
	print("clicked")
	get_parent().get_node("Area2D").remove_emplacement();
	get_tree().get_root().get_node("Carcassonne").fin_tour_joueur()
	self.hide()
