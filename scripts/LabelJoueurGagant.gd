extends Label

var static_text = "Joueur Gagant: "

var etat_text = ["égalité", "j 1", "j 2"]

func _on_ready():
	text = static_text

func update_text():
	var score_joueur1 = get_parent().get_node("LabelScore").score_joueur1 
	var score_joueur2 = get_parent().get_node("LabelScore").score_joueur2
	
	var etat = 0
	
	if(score_joueur1 > score_joueur2):
		etat = 1
	if(score_joueur1 < score_joueur2):
		etat = 2
	if(score_joueur1 == score_joueur2):
		etat = 0
	
	text = static_text + etat_text[etat];
