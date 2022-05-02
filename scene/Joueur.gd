extends Node2D

class_name Joueur

var score
var list_meeple : Array =[null, null, null, null, null, null, null]

func Joueur():
	pass

func add_meeple(meeple_obj,indice_tableau):
	list_meeple[indice_tableau] = meeple_obj
