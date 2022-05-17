extends Control


var Game_Data = {
	"type_joueur_1" : "HUMAIN",
	"difficult_joueur_1" : "NONE",
	"type_joueur_2" : "ROBOT",
	"difficult_joueur_2" : "FACILE"
}

onready var OptionButtonChoseDifficulty1 = get_node("VBoxContainer/OptionJ1/OptionButtonChoseDifficulty1")
onready var OptionButtonChoseDifficulty2 = get_node("VBoxContainer/OptionJ2/OptionButtonChoseDifficulty2")
onready var OptionButtonChosePlayer1 = get_node("VBoxContainer/OptionJ1/OptionButtonChosePlayer1")
onready var OptionButtonChosePlayer2 = get_node("VBoxContainer/OptionJ2/OptionButtonChosePlayer2")

func _ready():
	Game_Data = get_node("InputOutput").load_game_data()
	update_options_joueurs()

func _on_OptionButtonChosePlayer1_item_selected(index):
	if(index == 0):
		Game_Data.type_joueur_1 = "HUMAIN"
		Game_Data.difficult_joueur_1 = "NONE"
	if(index == 1):
		Game_Data.type_joueur_1 = "ROBOT"
		if(Game_Data.difficult_joueur_1 == "NONE"):
			Game_Data.difficult_joueur_1 = "FACILE"
	update_options_joueurs()
	
func _on_OptionButtonChosePlayer2_item_selected(index):
	if(index == 0):
		Game_Data.type_joueur_2 = "HUMAIN"
		Game_Data.difficult_joueur_2 = "NONE"
	if(index == 1):
		Game_Data.type_joueur_2 = "ROBOT"
		if(Game_Data.difficult_joueur_2 == "NONE"):
			Game_Data.difficult_joueur_2 = "FACILE"
	update_options_joueurs()

func _on_OptionButtonChoseDifficulty1_item_selected(index):
	if(index == 0):
		Game_Data.difficult_joueur_1 = "FACILE"
	if(index == 1):
		Game_Data.difficult_joueur_1 = "NORMAL" 
	update_options_joueurs()

func _on_OptionButtonChoseDifficulty2_item_selected(index):
	if(index == 0):
		Game_Data.difficult_joueur_2 = "FACILE"
	if(index == 1):
		Game_Data.difficult_joueur_2 = "NORMAL" 
	update_options_joueurs()

func update_options_joueurs():
	if(Game_Data.type_joueur_1 == "HUMAIN"):
		OptionButtonChosePlayer1.select(0)
		OptionButtonChoseDifficulty1.hide()
		
	if(Game_Data.type_joueur_1 == "ROBOT"):
		OptionButtonChosePlayer1.select(1)
		OptionButtonChoseDifficulty1.show()
		if(Game_Data.difficult_joueur_1 == "FACILE"):
			OptionButtonChoseDifficulty1.select(0)
		if(Game_Data.difficult_joueur_1 == "NORMAL"):
			OptionButtonChoseDifficulty1.select(1)
		
	if(Game_Data.type_joueur_2 == "HUMAIN"):
		OptionButtonChosePlayer2.select(0)
		OptionButtonChoseDifficulty2.hide()
	
	if(Game_Data.type_joueur_2 == "ROBOT"):
		OptionButtonChosePlayer2.select(1)
		OptionButtonChoseDifficulty2.show()
		if(Game_Data.difficult_joueur_2 == "FACILE"):
			OptionButtonChoseDifficulty2.select(0)
		if(Game_Data.difficult_joueur_2 == "NORMAL"):
			OptionButtonChoseDifficulty2.select(1)

func _on_ButtonSave_pressed():
	get_node("InputOutput").save_game_data(Game_Data)
