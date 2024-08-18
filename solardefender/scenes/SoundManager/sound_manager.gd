extends Node2D
@onready var explosion: AudioStreamPlayer2D = $Explosion
@onready var shooting: AudioStreamPlayer2D = $Shooting


func play_explosion()-> void:
	explosion.play()
	
func play_shooting()-> void:
	shooting.play()
