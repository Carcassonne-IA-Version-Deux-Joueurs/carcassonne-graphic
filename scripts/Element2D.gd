extends Area2D

var id = 0

signal id_send;

func set_id(id):
	self.id = id;

func _on_Element2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				print(id)
				emit_signal("id_send", id, get_global_mouse_position());
