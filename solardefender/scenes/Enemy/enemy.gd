extends Node2D

@onready var marker_2d: Marker2D = $Enemy/Marker2D

var speed: float
var direction: Vector2
var startingPosition: Vector2

func _ready() -> void:
	speed = set_enemy_speed()
	startingPosition = global_position
	
func _process(delta: float) -> void:
	global_position += direction * speed * delta


func set_direction(enemy_direction: Vector2) -> void:
	direction = enemy_direction

func set_enemy_starting_position(startingPosition) -> void:
	global_position = startingPosition
	
func set_enemy_speed() -> float:
	return randf_range(GameManager.enemy_speed_min, GameManager.enemy_speed_max)

func get_enemy_starting_position() -> Vector2:
	return startingPosition

func get_random_position_outside_viewport() -> Vector2:
	var viewport_size = get_viewport_rect().size
	var position = Vector2()
	
	# Randomly choose one of the four edges (left, right, top, bottom)
	var edge = randi() % 4
	match edge:
		0:  # Left side
			position.x = randf_range(-viewport_size.x, 0)
			position.y = randf_range(-viewport_size.y * 0.5, viewport_size.y * 1.5)
		1:  # Right side
			position.x = randf_range(viewport_size.x, viewport_size.x * 2)
			position.y = randf_range(-viewport_size.y * 0.5, viewport_size.y * 1.5)
		2:	# Top side
			position.x = randf_range(-viewport_size.x * 0.5, viewport_size.x * 1.5)
			position.y = randf_range(-viewport_size.y, 0)
		3:  # Bottom side
			position.x = randf_range(-viewport_size.x * 0.5, viewport_size.x * 1.5)
			position.y = randf_range(viewport_size.y, viewport_size.y * 2)
	return position
