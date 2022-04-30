extends Camera2D

var dragging = false
var target_position 

func _ready():
	current = true
	target_position = Vector2(0,0);

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		target_position .x = target_position .x + 10
	if Input.is_action_pressed("ui_left"):
		target_position .x = target_position .x - 10
	if Input.is_action_pressed("ui_up"):
		target_position .y = target_position .y - 10
	if Input.is_action_pressed("ui_down"):
		target_position .y = target_position .y + 10
	
	self.position = lerp(self.position, target_position, 0.05)
