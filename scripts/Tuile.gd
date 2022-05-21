extends Area2D

signal tuile_coord

onready var Element2D = load("res://scene/Element2D.tscn")

var position_grille
var orientation = 0
var vector_orientation
var element_list : Array
var element_position 
var carcassonne
var id_element = -1 # -1 si rien n'est séléctionné
var element_coord_global : Array = []

func _ready():
	position_grille = Vector2(71 + (position.x/255), 71 + ((-position.y)/255))
	carcassonne = get_tree().get_root().get_child(0).get_node("ViewportContainer").get_node("Viewport").get_node("Carcassonne").carcassonne
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
	get_parent().get_node("ButtonRotation").hide()
	get_parent().get_node("ButtonValiderTuile").hide()

func afficher_element():
	print("Element disponible")
	carcassonne.calcul_element_libre()
	var list_coord = carcassonne.get_coord_element_tuile_pioche()
	print(list_coord)
	var corner_bottom_left_coord = Vector2(-(255/2), (255/2))
	var id = 0;
	for element_coord in list_coord:
		var element_obj = Element2D.instance()
		var element_coord_scale = Vector2(corner_bottom_left_coord.x + (element_coord.x * 255), corner_bottom_left_coord.y - (element_coord.y * 255))
		element_obj.get_child(0).position = element_coord_scale
		element_obj.get_child(0).get_child(1).texture = load("res://asset/emplacement.png")
		element_obj.get_child(0).set_id(id)
		element_list.append(element_obj)
		element_coord_global.append(element_obj.get_child(0).global_position)
		element_obj.get_child(0).connect("id_send", self, "set_element_id")
		add_child(element_obj);
		print(carcassonne.get_points_espere_element(id, 1))
		id += 1

func get_coord_element_orientation(element_coord):
	print("orientation =" + str(vector_orientation[orientation]))
	if vector_orientation[orientation] == 0:
		var origine = Vector2(-(255/2), (255/2))
		return Vector2(origine.x + (element_coord.x * 255), origine.y - (element_coord.y  * 255))
	if vector_orientation[orientation] == 1:
		var origine = Vector2(-(255/2), -(255/2))
		return Vector2(origine.x + (element_coord.y * 255), origine.y + (element_coord.x  * 255))
	if vector_orientation[orientation] == 2:
		var origine = Vector2((255/2), -(255/2)) 
		return Vector2(origine.x - (element_coord.x * 255), origine.y + (element_coord.y  * 255))
	if vector_orientation[orientation] == 3:
		var origine = Vector2((255/2), (255/2))
		return Vector2(origine.x - (element_coord.y * 255), origine.y - (element_coord.x * 255))

func poser_meeple_element(id_element, joueur_id):
	print("poser meeple element")
	carcassonne.calcul_element_libre()
	var list_coord = carcassonne.get_coord_element_tuile_pioche()
	print(list_coord)

	var element_coord = list_coord[id_element]
	
	var element_obj = Element2D.instance()
	var element_coord_scale = get_coord_element_orientation(element_coord)
	element_obj.get_child(0).connect("id_send", self, "set_element_id")
	get_tree().get_root().get_child(0).get_node("ViewportContainer/Viewport/Carcassonne").poser_meeple(element_coord_scale + position, joueur_id , carcassonne.get_premier_meeple_indice_libre(joueur_id))
	carcassonne.poser_meeple(joueur_id, id_element, carcassonne.get_premier_meeple_indice_libre(joueur_id))

func set_element_id(id, position):
	id_element = id
	element_position = position

func get_element_id():
	return id_element

func get_element_coord():
	return element_position

func remove_element():
	for element_obj in element_list:
		remove_child(element_obj)

func _on_TuileArea2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				emit_signal("tuile_coord", self)

