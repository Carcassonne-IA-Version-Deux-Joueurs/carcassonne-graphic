extends Button


func _ready():
	pass


func _on_ButtonQuit_pressed():
	print_debug("Bye")
	get_tree().quit() # exit game
