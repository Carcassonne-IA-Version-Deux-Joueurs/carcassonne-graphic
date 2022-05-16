extends Label

var static_text = "Nombre de Tours Restant: "

func _on_ready():
	update_text(0)

func update_text(nbr_tour):
	text = static_text + str(71 - nbr_tour)
