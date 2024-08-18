extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var direction: Vector2

func _ready() -> void:
	await get_tree().create_timer(GameManager.bullet_lifespan).timeout
	self.queue_free()

func _physics_process(delta) -> void:
	global_position += direction * GameManager.BULLET_SPEED * delta

func set_direction(bullet_direction: Vector2) -> void:
	direction = bullet_direction


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		GameManager.add_points(5)
		SoundManager.play_explosion()
		body.queue_free()
		self.queue_free()
