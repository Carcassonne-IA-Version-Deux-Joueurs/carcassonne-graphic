extends Node2D


onready var Tuile2D = preload("res://scene/Tuile2D.tscn")
onready var TuileIcon2D = preload("res://scene/TuileIcon2D.tscn")

var carcassonne;

var tuileicon

var obj_tuiles_libre : Array;

var token = 0; # 0 neutre, 1 joueur, 2 robot

func _ready():
	carcassonne = Carcassonne.new()
	carcassonne.init_jeu()
	init_plateau();
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
	#token = 2
	token = 1

func fin_tour_robot():
	token = 1

func position_tuile(obj):
	print(obj.position)
	unset_icon_mouse()
	var tuile_id = carcassonne.tuile_pioche_id() 
	var tuile_obj = Tuile2D.instance()
	tuile_obj.get_child(0).get_child(0).texture = load("res://asset/tuiles/" + str(tuile_id) + ".png")
	tuile_obj.get_child(0).position = obj.position
	
	for tuile in obj_tuiles_libre:
		print("deconnexion")
		tuile.disconnect("tuile_coord", self, "position_tuile")
	
	#tuile_obj.get_child(0).get_child(2).visible = false
	#print(tuile_obj.get_child(0).get_child(2).visible)
	add_child(tuile_obj)
	for tuile in obj_tuiles_libre:
		remove_child(tuile.get_parent())
	obj_tuiles_libre.clear()
	#remove_child(obj.get_parent())
	
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
	print(carcassonne.get_coord_emplacement_libre())
	for coord in array_coord:
		var tuile_obj = Tuile2D.instance()
		var tuile = tuile_obj.get_child(0)
		print("coordonnée tuile placé: " + str(coord))
		tuile.position = Vector2((71 - coord.x) * (-255), (71 - coord.y)*255)
		tuile.get_child(0).texture = load("res://asset/dos1.png")
		tuile_obj.get_child(1).hide()
		tuile_obj.get_child(2).hide()
		tuile_obj.get_child(3).hide()
		add_child(tuile_obj)
		obj_tuiles_libre.append(tuile)
