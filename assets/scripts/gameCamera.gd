extends Camera2D

@export_group("Background")
@export var backgroundColor = Color.BLACK
var width := 1152
var height := 648

func _ready():
	RenderingServer.set_default_clear_color(backgroundColor)
