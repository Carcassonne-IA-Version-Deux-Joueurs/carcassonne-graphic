extends Button

func _ready():
	var position_parent = get_parent().get_child(0).position
	set_position(Vector2(position_parent.x, position_parent.y + 120))
	pass

func _on_ButtonValiderMeeple_pressed():
	get_parent().get_node("Area2D").remove_element()
	var id = get_parent().get_node("Area2D").get_element_id()
	if id != -1:
		var indice = get_tree().get_root().get_node("Carcassonne").carcassonne.get_premier_meeple_indice_libre(1)
		print(indice)
		get_tree().get_root().get_node("Carcassonne").poser_meeple(get_parent().get_node("Area2D").get_element_coord(), 1,indice)
		get_tree().get_root().get_node("Carcassonne").carcassonne.poser_meeple(1, get_parent().get_node("Area2D").id_element, indice)
	get_tree().get_root().get_node("Carcassonne").fin_tour_joueur()
	self.hide()
