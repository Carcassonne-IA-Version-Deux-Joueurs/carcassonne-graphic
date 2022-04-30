extends Button

func _ready():
	var position_parent = get_parent().get_child(0).position
	set_position(Vector2(position_parent.x, position_parent.y + 30))
	pass

func _on_ButtonValider_pressed():
	print("clicked")
	get_parent().get_child(0).poser_tuile()
	get_parent().get_node("ButtonValiderMeeple").show()
	###
	###
