extends Label

var static_text = "Type Joueur 2: "

func _on_ready():
	update_text("NONE")

func update_text(type_joueur):
	text = static_text + type_joueur
