extends Node

var lives: int = 4

var score: int = 0
var currentActiveWorld: int = 0

var BULLET_SPEED: float = 250.0
var time_between_shots: float = 0.9
var bullet_lifespan: float = 1.5

var enemy_speed_min: float = 20
var enemy_speed_max: float = 50
var enemy_spawn_time: float = 5

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
		
func resetGameStats() -> void:
	lives = 4
	score = 0
	currentActiveWorld = 0
	BULLET_SPEED = 250.0
	time_between_shots = 0.9
	bullet_lifespan = 1.5
	enemy_speed_min = 20
	enemy_speed_max = 50
	enemy_spawn_time = 5
