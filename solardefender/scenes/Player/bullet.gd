extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var direction: Vector2

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	self.queue_free()

func _physics_process(delta) -> void:
	global_position += direction * GameManager.BULLET_SPEED * delta

func set_direction(bullet_direction: Vector2) -> void:
	direction = bullet_direction
