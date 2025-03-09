extends Area2D

var upscaling

func _ready() -> void:
	upscaling = true

func _process(delta: float) -> void:
	if upscaling == true and self.scale.x < 50:
		self.scale.x += 25 * delta
		self.scale.y += 25 * delta
	elif self.scale.x > 0:
		upscaling = false
		self.scale.x -= 50 * delta
		self.scale.y -= 50 * delta
	else:
		self.queue_free()
		
func destroy():
	pass
