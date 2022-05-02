extends Node2D

onready var Tuile2D = preload("res://scene/Tuile2D.tscn")
onready var TuileIcon2D = preload("res://scene/TuileIcon2D.tscn")
onready var Meeple2D = preload("res://Meeple2D.tscn")

var carcassonne : Carcassonne

var tuileicon
var token = 0; # 0 neutre, 1 joueur, 2 robot

var target_zoom : Vector2

var obj_tuiles_libre : Array

var joueur1 : Joueur
var joueur2 : Joueur

func _ready():
	target_zoom = $Camera2D.zoom
	carcassonne = Carcassonne.new()
	carcassonne.init_jeu()
	init_plateau()
	joueur1 = Joueur.new()
	joueur2 = Joueur.new()
	
	token = 1
		
func _process(delta):
	if token == 1:
		joueur()
		token = 0
	if token == 2:
		robot()
		token = 0
	
func joueur():
	piocher_tuile();
	carcassonne.calcul_emplacement_libre()
	placer_tuile_emplacement_libre()
	for tuile in obj_tuiles_libre:
		tuile.connect("tuile_coord", self, "position_tuile") # connection des tuiles à cliquer pour le joueur
	set_icon_mouse()

func set_icon_mouse():
	tuileicon = TuileIcon2D.instance()
	tuileicon.get_child(0).texture = load("res://asset/tuiles/" + str(carcassonne.tuile_pioche_id()) + ".png")
	add_child(tuileicon)

func unset_icon_mouse():
	remove_child(tuileicon)
	
func robot():
	piocher_tuile();
	carcassonne.calcul_emplacement_libre()
	placer_tuile_emplacement_libre()
	# robot doing...

func fin_tour_joueur():
	print("liste meeple")
	print(carcassonne.get_meeple_pose_array(1))
	
	print("evaluation")
	carcassonne.evaluation_points_meeple()
	
	print("liste_meeple")
	print(carcassonne.get_meeple_pose_array(1))
	
	print("update list")
	update_meeple_list(1)
	#token = 2
	token = 1

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
	#print(carcassonne.get_coord_emplacement_libre())
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
	print("poser meeple")
	var meeple_obj = Meeple2D.instance()
	meeple_obj.get_node("Sprite").texture = load("res://asset/meeple.png")
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
					target_zoom = target_zoom - Vector2(0.05,0.05)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				target_zoom = target_zoom + Vector2(0.05,0.05)
	$Camera2D.zoom = target_zoom;
