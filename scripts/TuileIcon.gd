extends Sprite

var target_position;

func _ready():
	target_position = Vector2(0,0)
	self.scale = Vector2(0.5,0.5)
	pass # Replace with function body.

func _process(_delta):
	target_position = get_global_mouse_position()
	self.position = lerp(self.position, target_position, 0.1)
