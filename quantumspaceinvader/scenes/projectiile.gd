extends Area2D

var SPEED = 300
var up = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= SPEED * up * delta


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	self.queue_free()
