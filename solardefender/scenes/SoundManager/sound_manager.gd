extends Node2D
@onready var explosion: AudioStreamPlayer2D = $Explosion
@onready var shooting: AudioStreamPlayer2D = $Shooting
@onready var background: AudioStreamPlayer2D = $Background
@onready var teleport: AudioStreamPlayer2D = $Teleport

func play_explosion()-> void:
	explosion.play()
	
func play_shooting()-> void:
	shooting.play()

func play_teleport()-> void:
	teleport.play()
