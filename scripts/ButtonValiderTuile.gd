extends Button

func _ready():
	var position_parent = get_parent().get_child(0).position
	set_position(Vector2(position_parent.x, position_parent.y + 120))

func _on_ButtonValider_pressed():
	get_parent().get_child(0).poser_tuile()
	var carcassonne = get_tree().get_root().get_child(0).get_node("ViewportContainer").get_node("Viewport").get_node("Carcassonne")
	print("Nombre de meeple restant" + str(carcassonne.get_nbr_meeple(carcassonne.get_joueur_courant()))) 
	if(carcassonne.get_nbr_meeple(carcassonne.get_joueur_courant()) > 0):
		get_parent().get_child(0).afficher_element()
		get_parent().get_node("ButtonValiderMeeple").show()
	else:
		carcassonne.fin_tour_joueur()
