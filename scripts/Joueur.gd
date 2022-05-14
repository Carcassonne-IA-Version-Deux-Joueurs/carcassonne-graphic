extends Node2D

class_name Joueur

onready var score = 0
var list_meeple : Array =[null, null, null, null, null, null, null]

func Joueur():
	pass

func add_meeple(meeple_obj,indice_tableau):
	list_meeple[indice_tableau] = meeple_obj

func update_score(score):
	self.score = score
