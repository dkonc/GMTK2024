extends Node

var lives: int = 4

var score: int = 0
var currentActiveWorld: int = 0

var BULLET_SPEED: float = 200.0
var time_between_shots: float = 0.9
var bullet_lifespan: float = 1.3

var enemy_speed_min: float = 30
var enemy_speed_max: float = 70
var enemy_spawn_time: float = 4

func add_points(added_score: int) -> void:
	score = score + added_score
	
func reset_points() -> void:
	score = 0

func get_points() -> String:
	return str(score)

func switchWorldUp() -> void:
	if currentActiveWorld < 3:
		currentActiveWorld += 1
	
func switchWorldDown() -> void:
	if currentActiveWorld > 0:
		currentActiveWorld -= 1
