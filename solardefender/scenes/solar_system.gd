extends Node2D

@export var planets: Array[AnimatableBody2D]
@export var scales: Array[Path2D]
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	player.position = planets[GameManager.currentActiveWorld].position
	#Path and actual position is determined by scale of the Path... so I have to adjust for it
	player.position *= scales[GameManager.currentActiveWorld].scale.x
