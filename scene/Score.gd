extends Label

func _ready():
	text = "joueur 1: 0\njoueur 2: 0"
	
func update_score():
	var score_j1 = get_tree().get_root().get_node("Carcassonne").get_joueur(1).score
	var score_j2 = get_tree().get_root().get_node("Carcassonne").get_joueur(2).score
	text = "joueur 1: "+ str(score_j1) + "\njoueur 2: " + str(score_j2);
