extends Control

var save_path = "user://carcassonne_config.data"

var key = "carcassonne_key"

func save_game_data(Game_Data):
	print(Game_Data)
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, key)
	if error == OK:
		file.store_var(Game_Data)
		file.close()
		print_debug("Options are stored at " + save_path)
	else:
		print_debug("Can't store data at " + save_path)

func load_game_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, key)
		if error == OK:
			var Game_Data = file.get_var()
			file.close()
			print(Game_Data)
			print_debug("options are loaded")
			return Game_Data
		else:
			print_debug("Can't open data" + save_path)
	else:
		print_debug("data not found: default setting")
