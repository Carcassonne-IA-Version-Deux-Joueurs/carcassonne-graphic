extends Camera2D

var dragging = false
var target_position 
var target_zoom = Vector2(1,1)

func _ready():
	current = true
	target_position = Vector2(0,0);
	self.zoom = Vector2(4,4)

func set_target_zoom(target_entry_zoom):
	self.target_zoom = target_entry_zoom

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		target_position .x = target_position .x + 10
	if Input.is_action_pressed("ui_left"):
		target_position .x = target_position .x - 10
	if Input.is_action_pressed("ui_up"):
		target_position .y = target_position .y - 10
	if Input.is_action_pressed("ui_down"):
		target_position .y = target_position .y + 10
	
	self.position = lerp(self.position, target_position, 0.05)
	self.zoom = lerp(self.zoom, target_zoom, 0.05)
