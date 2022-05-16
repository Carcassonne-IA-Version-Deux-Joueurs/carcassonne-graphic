extends Label

var static_text = "Tour du Joueur"

func _on_ready():
	update_text(1)

func update_text(joueur_id):
	text = static_text + str(joueur_id)
