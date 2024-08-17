extends Path2D

@onready var platform: Path2D = $"."
@onready var path: PathFollow2D = $PathFollow2D
@onready var line_2d: Line2D = $Line2D

@export var speed: float = 100.0

func _ready() -> void:
	path.progress = 0
	line_2d.default_color = Color(1, 1, 1, 0.1)
	line_2d.width = 1
	for point in platform.curve.get_baked_points():
		line_2d.add_point(point + platform.position)

func _process(delta) -> void:  
	path.progress += speed * delta
