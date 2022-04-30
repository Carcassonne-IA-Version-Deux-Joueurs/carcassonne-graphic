extends Button

func _ready():
	set_position(get_parent().get_child(0).position)
	pass

func _on_Button_pressed():
	get_parent().get_child(0).do_rotation()
