extends Area2D

signal tuile_coord

onready var Element2D = load("res://scene/Element2D.tscn")

var position_grille;
onready var orientation = 0;
var vector_orientation;
var element_list : Array;

var carcassonne

func _ready():
	position_grille = Vector2(71 + (position.x/255), 71 + ((-position.y)/255))
	print(position)
	carcassonne = get_tree().get_root().get_node("Carcassonne").carcassonne
	var list_orientation = carcassonne.get_coord_emplacement_libre()
	if list_orientation.has(position_grille):
		vector_orientation = list_orientation[position_grille]
		rotation += ((PI/2) * vector_orientation[0])
	get_parent().get_child(3).hide()
	
func do_rotation():
	orientation = (orientation + 1) % vector_orientation.size()
	print(vector_orientation[orientation])
	rotation = 0
	rotation += ((PI/2) * vector_orientation[orientation])

func poser_tuile():
	print("poser tuile")
	print(position_grille)
	print(vector_orientation[orientation])
	carcassonne.poser_tuile_pioche(position_grille.x, position_grille.y, vector_orientation[orientation])
	#for i in range(0,144):
	#	for j in range(0,144):
	#		if carcassonne.get_coord_id(i,j) != -2:
	#			print(str(i) + str(j) + ':' + str(carcassonne.get_coord_id(i,j)))
	get_parent().get_node("ButtonRotation").hide()
	get_parent().get_node("ButtonValiderTuile").hide()
	afficher_element()
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("tuile_coord", self)

func afficher_element():
	print("Element disponible")
	var list_coord = carcassonne.get_coord_element_tuile_pioche()
	print(list_coord)
	var corner_bottom_left_coord = Vector2(-(255/2), (255/2))
	
	for element_coord in list_coord:
		var element_obj = Element2D.instance()
		var element_coord_scale = Vector2(corner_bottom_left_coord.x + (element_coord.x * 255), corner_bottom_left_coord.y - (element_coord.y * 255))
		element_obj.get_child(0).position = element_coord_scale
		element_obj.get_child(0).get_child(1).texture = load("res://asset/emplacement.png")
		element_list.append(element_obj)
		add_child(element_obj);
	
func remove_emplacement():
	for element_obj in element_list:
		remove_child(element_obj)
		
