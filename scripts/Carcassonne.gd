extends Node2D

onready var Tuile2D = preload("res://scene/Tuile2D.tscn")
onready var TuileIcon2D = preload("res://scene/TuileIcon2D.tscn")
onready var Meeple2D = preload("res://scene/Meeple2D.tscn")


var carcassonne : Carcassonne
var Game_Data

var tuileicon
var token = 0; # 0 neutre, 1 joueur, 2 robot

var nbr_tour = 0


var target_zoom = Vector2(1,1)

var obj_tuiles_libre : Array

var joueur1 : Joueur
var joueur2 : Joueur

# Initilisations des Labels du bandeau
onready var labelJoueur = get_tree().get_root().get_node("Jeu_Principal").get_node("HeadBand").get_node("HeadBandText").get_node("LabelJoueur")
onready var labelScore  = get_tree().get_root().get_node("Jeu_Principal").get_node("HeadBand").get_node("HeadBandText").get_node("LabelScore")
onready var labelJoueurGagnant = get_tree().get_root().get_node("Jeu_Principal").get_node("HeadBand").get_node("HeadBandText").get_node("LabelJoueurGagnant")
onready var labelTuileRestant  = get_tree().get_root().get_node("Jeu_Principal").get_node("HeadBand").get_node("HeadBandText").get_node("LabelTuileRestant")
onready var labelFinDuJeu  = get_tree().get_root().get_node("Jeu_Principal").get_node("HeadBand").get_node("HeadBandText").get_node("LabelFinDuJeu")
onready var labelNbrMeepleRestant  = get_tree().get_root().get_node("Jeu_Principal").get_node("HeadBand").get_node("HeadBandText").get_node("LabelNbrMeepleRestant")
onready var labelTypeJ1 = get_tree().get_root().get_node("Jeu_Principal/HeadBand/HeadBandText/LabelTypeJ1")
onready var labelTypeJ2 = get_tree().get_root().get_node("Jeu_Principal/HeadBand/HeadBandText/LabelTypeJ2")

func _ready():
	Game_Data = get_node("InputOutput").load_game_data()
	print(Game_Data)
	target_zoom = $Camera2D.zoom
	carcassonne = Carcassonne.new()
	carcassonne.init_jeu(Game_Data)
	init_plateau()
	joueur1 = Joueur.new()
	joueur2 = Joueur.new()
	joueur1.set_type_joueur(Game_Data.type_joueur_1)
	joueur2.set_type_joueur(Game_Data.type_joueur_2)
	labelTypeJ1.update_text(joueur1.type_joueur)
	labelTypeJ2.update_text(joueur2.type_joueur)
	nbr_tour = 0
	labelFinDuJeu.hide()
	choose_player()

func choose_player():
	nbr_tour = nbr_tour + 1
	labelTuileRestant.update_text(nbr_tour)
	
	if(nbr_tour == 71):
		fin_du_jeu()
	else:
		joueur1.update_score(carcassonne.get_joueur_score(1))
		joueur2.update_score(carcassonne.get_joueur_score(2))
		labelScore.update_text(1, joueur1.score)
		labelScore.update_text(2, joueur2.score)
	
		labelJoueurGagnant.update_text()
		
		joueur1.update_nbr_meeple(carcassonne.get_nbr_pion_joueur(1))
		joueur2.update_nbr_meeple(carcassonne.get_nbr_pion_joueur(2))
		labelNbrMeepleRestant.update_text(1, joueur1.nbr_meeple)
		labelNbrMeepleRestant.update_text(2, joueur2.nbr_meeple)
		
		if token == 0:
			if(joueur1.type_joueur == "HUMAIN"):
				tour_humain(token + 1)
			if(joueur1.type_joueur == "ROBOT"):
				tour_du_robot(token + 1)
		if token == 1:
			if(joueur2.type_joueur == "HUMAIN"):
				tour_humain(token + 1)
			if(joueur2.type_joueur == "ROBOT"):
				tour_du_robot(token + 1)

func get_nbr_meeple(joueur_id):
	return carcassonne.get_nbr_pion_joueur(joueur_id)

func fin_du_jeu():
	labelFinDuJeu.show()
	carcassonne.evaluation_points_meeple_final()
	joueur1.update_score(carcassonne.get_joueur_score(1))
	joueur2.update_score(carcassonne.get_joueur_score(2))
	labelScore.update_text(1, joueur1.score)
	labelScore.update_text(2, joueur2.score)
	labelJoueurGagnant.update_text()
	print_debug("fin du jeu")

func tour_humain(id):
	piocher_tuile();
	carcassonne.calcul_emplacement_libre()
	labelJoueur.update_text(id)
	placer_tuile_emplacement_libre()
	for tuile in obj_tuiles_libre:
		tuile.connect("tuile_coord", self, "position_tuile") # connection des tuiles à cliquer pour le joueur
	set_icon_mouse()

func tour_du_robot(id):
	piocher_tuile();
	carcassonne.calcul_emplacement_libre()
	carcassonne.ia_joue(id)
	labelJoueur.update_text(id)
	placer_tuile_emplacement_libre()
	var tuile_id = carcassonne.tuile_pioche_id() 
	var tuile_obj = Tuile2D.instance()
	print(carcassonne.get_joueur_emplacement_choisi(id))
	print(obj_tuiles_libre)
	tuile_obj.get_child(0).get_child(0).texture = load("res://asset/tuiles/" + str(tuile_id) + ".png")
	var coord_tuile = carcassonne.get_joueur_emplacement_choisi(id)
	var position_de_la_tuile = Vector2(coord_tuile[0],coord_tuile[1])
	tuile_obj.get_child(0).position = Vector2((71 - position_de_la_tuile.x) * -255, (71 - position_de_la_tuile.y) * 255)
	print(coord_tuile)
	print(tuile_obj.get_child(0).position)
	tuile_obj.get_node("ButtonRotation").hide()
	tuile_obj.get_node("ButtonValiderTuile").hide()
	add_child(tuile_obj)
	print(tuile_obj.get_child(0).do_rotation())
	while(tuile_obj.get_child(0).vector_orientation[tuile_obj.get_child(0).orientation] != coord_tuile[2]):
		tuile_obj.get_child(0).do_rotation()
	print(tuile_obj.get_child(0).vector_orientation)
	#print(tuile_obj.position)
	for tuile in obj_tuiles_libre:
		remove_child(tuile.get_parent())
	obj_tuiles_libre.clear()
	fin_tour_joueur()

func objet_tuile_position_indice(obj_tuiles_libre, indice):
	pass

func set_icon_mouse():
	tuileicon = TuileIcon2D.instance()
	tuileicon.get_child(0).texture = load("res://asset/tuiles/" + str(carcassonne.tuile_pioche_id()) + ".png")
	add_child(tuileicon)

func unset_icon_mouse():
	remove_child(tuileicon)

func fin_tour_joueur():
	print("liste meeple")
	print(carcassonne.get_meeple_pose_array(1))
	
	print("evaluation")
	carcassonne.evaluation_points_meeple()
	
	print("liste_meeple")
	print(carcassonne.get_meeple_pose_array(1))
	
	print("update list")
	update_meeple_list(1)
	update_meeple_list(2)
	print(token)
	token = (token + 1) % 2
	choose_player()

func fin_tour_robot():
	token = 1

func position_tuile(obj):
	#print(obj.position)
	unset_icon_mouse()
	var tuile_id = carcassonne.tuile_pioche_id() 
	var tuile_obj = Tuile2D.instance()
	tuile_obj.get_child(0).get_child(0).texture = load("res://asset/tuiles/" + str(tuile_id) + ".png")
	tuile_obj.get_child(0).position = obj.position
	
	for tuile in obj_tuiles_libre:
		tuile.disconnect("tuile_coord", self, "position_tuile")

	add_child(tuile_obj)
	for tuile in obj_tuiles_libre:
		remove_child(tuile.get_parent())
	obj_tuiles_libre.clear()
	
func init_plateau():
	# Tuile de base
	var tuile = Tuile2D.instance()
	tuile.get_child(1).hide()
	tuile.get_child(2).hide()
	tuile.get_child(3).hide()
	tuile.get_child(0).get_child(0).texture = load("res://asset/tuiles/1.png")
	add_child(tuile)

func piocher_tuile():
	carcassonne.piocher_tuile()

func placer_tuile_emplacement_libre():
	var array_coord : Dictionary = carcassonne.get_coord_emplacement_libre()
	print_debug(carcassonne.get_coord_emplacement_libre())
	for coord in array_coord:
		var tuile_obj = Tuile2D.instance()
		var tuile = tuile_obj.get_child(0)
		#print("coordonnée tuile placé: " + str(coord))
		tuile.position = Vector2((71 - coord.x) * (-255), (71 - coord.y)*255)
		tuile.get_child(0).texture = load("res://asset/dos1.png")
		tuile_obj.get_child(1).hide()
		tuile_obj.get_child(2).hide()
		tuile_obj.get_child(3).hide()
		add_child(tuile_obj)
		obj_tuiles_libre.append(tuile)

func poser_meeple(coord : Vector2, joueur_id, indice_tableau):
	print("poser meeple" + str(joueur_id))
	var meeple_obj = Meeple2D.instance()
	meeple_obj.get_node("MeepleSprite").set_texture_meeple(joueur_id)
	meeple_obj.position = coord
	get_joueur(joueur_id).add_meeple(meeple_obj,indice_tableau)
	add_child(meeple_obj)

func get_joueur(id : int):
	if id == 1:
		return self.joueur1
	if id == 2:
		return self.joueur2

func update_meeple_list(joueur_id):
	var joueur = self.get_joueur(joueur_id)
	print(joueur.list_meeple)
	var bool_meeple_pose = carcassonne.get_meeple_pose_array(joueur_id)
	var indice = 0;
	for meeple in joueur.list_meeple:
		if meeple != null:
			if bool_meeple_pose[indice] == false:
				remove_child(meeple)
				joueur.list_meeple[indice]  = null;
		indice += 1
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if(target_zoom > Vector2(0.4,0.4)): 
					target_zoom = target_zoom - Vector2(0.1,0.1)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				if(target_zoom < Vector2(5,5)): 
					target_zoom = target_zoom + Vector2(0.1,0.1)
	$Camera2D.set_target_zoom(target_zoom)

func get_joueur_courant():
	return token + 1
