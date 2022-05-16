extends Sprite

func _ready():
	pass # Replace with function body.

func set_texture_meeple(joueur_id):
	if(joueur_id == 1):
		texture = load("res://asset/meeple_j1.png")
	if(joueur_id == 2):
		texture = load("res://asset/meeple_j2.png")
