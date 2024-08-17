extends Node

var score: int = 0
var currentActiveWorld: int = 0


func add_points(added_score: int) -> void:
	score = score + added_score
	
func reset_points() -> void:
	score = 0

func get_points() -> String:
	return str(score)
