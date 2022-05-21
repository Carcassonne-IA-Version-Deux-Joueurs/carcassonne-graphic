extends Button

func _ready():
	var position_parent = get_parent().get_child(0).position
	set_position(Vector2(position_parent.x, position_parent.y + 120))
	pass

func _on_ButtonValiderMeeple_pressed():
	var carcassonne_obj = get_tree().get_root().get_child(0).get_node("ViewportContainer").get_node("Viewport").get_node("Carcassonne")
	get_parent().get_node("TuileArea2D").remove_element()
	var id = get_parent().get_node("TuileArea2D").get_element_id()
	if id != -1:
		var indice = carcassonne_obj.carcassonne.get_premier_meeple_indice_libre(carcassonne_obj.get_joueur_courant())
		print(indice)
		carcassonne_obj.poser_meeple(get_parent().get_node("TuileArea2D").get_element_coord(), carcassonne_obj.get_joueur_courant(), indice)
		carcassonne_obj.carcassonne.poser_meeple(carcassonne_obj.get_joueur_courant(), get_parent().get_node("TuileArea2D").id_element, indice)
	carcassonne_obj.fin_tour_joueur()
	self.hide()
