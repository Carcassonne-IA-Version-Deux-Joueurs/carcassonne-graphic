extends TileMap

func _ready():
	for i in range (-50,50):
		for j in range(-50,50):
			set_cell(i,j,0)
