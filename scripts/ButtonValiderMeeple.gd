extends Button

func _ready():
	var position_parent = get_parent().get_child(0).position
	set_position(Vector2(position_parent.x, position_parent.y + 120))
	pass

func _on_ButtonValiderMeeple_pressed():
	var carcassonne_obj = get_tree().get_root().get_child(0).get_child(0).get_node("ViewportContainer").get_node("Viewport").get_node("Carcassonne")
	get_parent().get_node("Area2D").remove_element()
	var id = get_parent().get_node("Area2D").get_element_id()
	if id != -1:
		var indice = carcassonne_obj.carcassonne.get_premier_meeple_indice_libre(1)
		print(indice)
		carcassonne_obj.poser_meeple(get_parent().get_node("Area2D").get_element_coord(), 1,indice)
		carcassonne_obj.carcassonne.poser_meeple(1, get_parent().get_node("Area2D").id_element, indice)
	carcassonne_obj.fin_tour_joueur()
	self.hide()
