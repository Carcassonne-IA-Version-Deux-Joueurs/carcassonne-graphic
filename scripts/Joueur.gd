extends Node2D

class_name Joueur

onready var score = 0
onready var nbr_meeple = 7
var list_meeple : Array = [null, null, null, null, null, null, null]

var type_joueur : String

func Joueur():
	pass

func add_meeple(meeple_obj,indice_tableau):
	list_meeple[indice_tableau] = meeple_obj

func update_score(score):
	self.score = score

func update_nbr_meeple(nbr_meeple):
	self.nbr_meeple = nbr_meeple

func set_type_joueur(type_joueur_entry):
	self.type_joueur = type_joueur_entry
