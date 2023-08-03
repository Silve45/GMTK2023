extends Camera2D

@export_group("Background")
@export var backgroundColor = Color.BLACK
var width := 1920
var height := 1080

#shake stuff
@export_group("Screenshake")
@export var shake_decay_rate: float = 5.0
@export var noise_shake_speed: float = 30.0
@export var noise_shake_strength: float = 60.0
@onready var noise = FastNoiseLite.new()

var noise_i: float = 0.0
var shake_strength: float = 0.0
var rand = RandomNumberGenerator.new()

func _ready():
	RenderingServer.set_default_clear_color(backgroundColor)
	#shake stuff
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = .6

func _apply_shake():
	shake_strength = noise_shake_strength

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, shake_decay_rate * delta)
	
	offset = get_noise_offset(delta)

func get_noise_offset(delta: float):
	noise_i += delta * noise_shake_speed
	
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)
