extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D
@onready var line_to_cursor: Line2D = $"../LineToCursor"
@onready var line_to_screen: Line2D = $"../LineToScreen"

const BULLET_NODE = preload("res://scenes/Player/bullet.tscn")
var can_shoot: bool = true

func _ready() -> void:
	line_to_cursor.default_color = Color(0, 0.798, 0.513)
	line_to_screen.default_color = Color(1, 1, 1, 1)
	line_to_cursor.width = 2
	line_to_screen.width = 2
	line_to_cursor.add_point(player.global_position)
	line_to_screen.add_point(get_global_mouse_position())
	line_to_cursor.add_point(get_global_mouse_position())
	line_to_screen.add_point((get_global_mouse_position() + (get_global_mouse_position() - player.global_position)*10))

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("switch_in")):
		GameManager.switchWorldUp()
	if(Input.is_action_just_pressed("switch_out")):
		GameManager.switchWorldDown()
	if(Input.is_action_just_pressed("shoot")):
		shoot()
	line_to_cursor.set_point_position(0,player.global_position)
	line_to_screen.set_point_position(0,get_global_mouse_position())
	line_to_cursor.set_point_position(1, get_global_mouse_position())
	line_to_screen.set_point_position(1,(get_global_mouse_position() + (get_global_mouse_position() - player.global_position)*10))

		
func shoot() -> void:
	if !can_shoot:
		return
	can_shoot = false
	timer.start(GameManager.time_between_shots)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	var bullet = BULLET_NODE.instantiate()
	bullet.global_position = marker_2d.global_position
	bullet.set_direction(set_bullet_direction())
	get_parent().add_child(bullet)

func set_bullet_direction() -> Vector2:
	var koncna_pozicija = get_global_mouse_position()
	var pozicija_clovecka = player.global_position
	return (koncna_pozicija-pozicija_clovecka).normalized()
	
	
	
	
	
	
	
	

func _on_timer_timeout() -> void:
	can_shoot = true
