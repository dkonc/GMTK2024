extends Node

var score: int = 0
var currentActiveWorld: int = 0

var BULLET_SPEED: float = 200.0
var time_between_shots: float = 0.1

func add_points(added_score: int) -> void:
	score = score + added_score
	
func reset_points() -> void:
	score = 0

func get_points() -> String:
	return str(score)

func switchWorldUp() -> void:
	if currentActiveWorld < 2:
		currentActiveWorld += 1
	
func switchWorldDown() -> void:
	if currentActiveWorld > 0:
		currentActiveWorld -= 1
