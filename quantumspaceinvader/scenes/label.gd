extends Label

var start_time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_ticks_msec() / 1000.0  # Get starting time in seconds
	print("Game start time (seconds): ", start_time)

# Called every frame to update the label text
func _process(delta):
	var elapsed_time = (Time.get_ticks_msec() / 1000.0) - start_time
	
	if elapsed_time > 60:
		var minutes = int(elapsed_time) / 60
		var seconds = int(elapsed_time) % 60
		text = "Qubit lifetime: %d min %d s" % [minutes, seconds]
		print("Qubit lifetime: %d min %d s" % [minutes, seconds])
	else:
		text = "Qubit lifetime: " + str(elapsed_time).pad_decimals(2) + " s"
		#print("Qubit lifetime: ", elapsed_time)
