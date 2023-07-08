extends Camera2D

@export_group("Background")
@export var backgroundColor = Color.BLACK
var width := 1920
var height := 1080

func _ready():
	RenderingServer.set_default_clear_color(backgroundColor)
