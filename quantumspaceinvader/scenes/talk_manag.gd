extends Sprite2D

@onready var timer: Timer = $"../Timer"  # Timer for random prints
@onready var talk: Label = $"../talk"  # Reference to the Label
@onready var talk_manag: Sprite2D = $"."

var sentences: Array = [
	"One more qubit bro.. I promise just one more",
	"I know a cat that can do that better...",
	"Entangle moi",
	"hello chef !!",
	"Where is bob ?"
	
]

var talk_pos: Array = [
	Vector2(-1532, 620),
	Vector2(-801, 785),
	Vector2(-1553, 806),
	Vector2(-12, 8),
	Vector2(1853, 902)
]

func _ready():
	randomize()  # Ensure randomness
	if timer:
		timer.wait_time = 10.0  # Set interval to 10 seconds
		timer.one_shot = false  # Make sure it repeats
		timer.start()  # Start the timer
		timer.timeout.connect(_on_Timer_timeout)  # Ensure it's connected

func _on_Timer_timeout():
	pick_random_sentence()

func pick_random_sentence():
	if sentences.is_empty() or talk_pos.is_empty():
		print("❌ No sentences or positions available!")
		return  

	# Pick a random sentence
	var random_sentence = sentences[randi() % sentences.size()]
	print(random_sentence)

	# Pick a random position from the array
	var random_position = talk_pos[randi() % talk_pos.size()]
	
	# Update the Label text and position
	if talk:
		talk.text = random_sentence
		talk.position = random_position
		talk_manag.position = random_position
		
		talk.show()
		talk_manag.show()
		

		# Hide after 3 seconds
		get_tree().create_timer(3.0).timeout.connect(func(): talk.hide())
		get_tree().create_timer(3.0).timeout.connect(func(): talk_manag.hide())
		
