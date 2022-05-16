extends Label

var meeple_joueur1 = 0
var meeple_joueur2 = 0

func _ready():
	update_text(1,7)
	update_text(2,7)
	
func update_text(joueur_id, nbr_meeple):
	if(joueur_id == 1):
		meeple_joueur1 = nbr_meeple
	if(joueur_id == 2):
		meeple_joueur2 = nbr_meeple
	text = "Nbr de Meeples joueur 1: " + str(meeple_joueur1) + "\nNbr de Meeples joueur 2: " + str(meeple_joueur2) 
