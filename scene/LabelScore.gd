extends Label

var score_joueur1 = 0
var score_joueur2 = 0

func _ready():
	update_text(1,0)
	update_text(2,0)
	
func update_text(joueur_id,score):
	if(joueur_id == 1):
		score_joueur1 = score
	if(joueur_id == 2):
		score_joueur2 = score
	text = "Score joueur 1:" + str(score_joueur1) + "\nScore joueur 2:" + str(score_joueur2) 
