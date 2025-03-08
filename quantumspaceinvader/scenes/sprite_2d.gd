extends Sprite2D

@onready var sprite = $Sprite2D

func _ready():
	update_background_size()

func _process(delta):
	update_background_size() # Ensure it updates when the window resizes

func update_background_size():
	var screen_size = get_viewport_rect().size
	var texture_size = sprite.texture.get_size()

	var scale_factor = max(screen_size.x / texture_size.x, screen_size.y / texture_size.y)
	sprite.scale = Vector2(scale_factor, scale_factor)
