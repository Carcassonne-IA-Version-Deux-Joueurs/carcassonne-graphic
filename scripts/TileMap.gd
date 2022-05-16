extends TileMap

func _ready():
	for i in range (-40,40):
		for j in range(-40,40):
			set_cell(i,j,0)
