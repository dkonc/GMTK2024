extends Node2D

@export var planets: Array[AnimatableBody2D]
@export var scales: Array[Path2D]
@onready var player: CharacterBody2D = $Player
const ENEMY_NODE = preload("res://scenes/Enemy/enemy.tscn")
@onready var camera_2d: Camera2D = $Camera2D
@onready var timer: Timer = $Timer
@onready var label_score: Label = $Camera2D/CanvasLayer/VBoxContainer/HBoxContainer2/Label2
@onready var label_lives: Label = $Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Label2
@onready var upgrade: CanvasLayer = $Upgrade
@onready var add_life: Button = $Upgrade/HBoxContainer/VBoxContainer/AddLife
@onready var add_bullet_speed: Button = $Upgrade/HBoxContainer/VBoxContainer/AddBulletSpeed
@onready var increase_fire_rate: Button = $Upgrade/HBoxContainer/VBoxContainer/IncreaseFireRate
@onready var increase_bullet_life: Button = $Upgrade/HBoxContainer/VBoxContainer2/IncreaseBulletLife
@onready var decrease_enemy_speed: Button = $Upgrade/HBoxContainer/VBoxContainer2/DecreaseEnemySpeed
@onready var decrease_enemy_spawn_time: Button = $Upgrade/HBoxContainer/VBoxContainer2/DecreaseEnemySpawnTime
@onready var get_points: Button = $Upgrade/HBoxContainer/VBoxContainer3/GetPoints
@onready var gamble_for_win: Button = $Upgrade/HBoxContainer/VBoxContainer3/GambleForWin
@onready var nothing_happens: Button = $Upgrade/HBoxContainer/VBoxContainer3/NothingHappens
@onready var win_button: Button = $WIN/WinButton
@onready var win: CanvasLayer = $WIN
@onready var lose: CanvasLayer = $LOSE
@onready var instructions: CanvasLayer = $Instructions

var enemiesShouldSpawn: bool = false

@export var drag_speed := 1.0  # Adjust the speed of the drag

var dragging := false
var last_mouse_position : Vector2


func _ready() -> void:
	timer.wait_time = GameManager.enemy_spawn_time
	camera_2d.zoom = Vector2(0.6,0.6)
	instructions.show()
	get_tree().paused = true
	
	
func _process(_delta: float) -> void:
	label_lives.text = str(GameManager.lives)
	label_score.text = str(GameManager.score)
	if(GameManager.lives<=0):
		get_tree().paused = true
		lose.show()
	if(GameManager.score % 50 == 5):
		triggerUpgrade()
	player.position = planets[GameManager.currentActiveWorld].position
	#Path and actual position is determined by scale of the Path... so I have to adjust for it
	player.position *= scales[GameManager.currentActiveWorld].scale.x
	
	if(Input.is_action_just_pressed("zoom_in")):
		if(camera_2d.zoom.x) < 1.7:
			camera_2d.zoom /= 0.9
	if(Input.is_action_just_pressed("zoom_out")):
		if(camera_2d.zoom.x) > 0.3:
			camera_2d.zoom /= 1.1
			
func _unhandled_input(event: InputEvent) -> void:			
	if Input.is_action_just_pressed("pan"):
		dragging = true
		last_mouse_position = get_viewport().get_mouse_position()

	# Stop dragging when the "pan" action is just released
	if Input.is_action_just_released("pan"):
		dragging = false
	# If dragging, move the camera
	if event is InputEventMouseMotion and dragging:
		var mouse_position = get_viewport().get_mouse_position()
		var mouse_delta = mouse_position - last_mouse_position
		last_mouse_position = mouse_position
		# Move the camera based on mouse delta
		camera_2d.global_position -= mouse_delta * drag_speed
	
func _on_timer_timeout() -> void:
	spawnEnemy()
	#Z vsakim spawnom se hitreje spawnajo
	if GameManager.enemy_spawn_time > 0.2:
		GameManager.enemy_spawn_time *= 0.99
	timer.wait_time = GameManager.enemy_spawn_time

func spawnEnemy() -> void:
	var enemy = ENEMY_NODE.instantiate()
	var selectRandomPlanet = randi_range(0, planets.size()-1)
	var startingPosition = get_random_position_on_camera_edge()
	enemy.set_direction(set_enemy_direction(selectRandomPlanet,startingPosition))
	enemy.set_enemy_starting_position(startingPosition)
	get_parent().add_child(enemy)
	
func set_enemy_direction(randomPlanet, enemyStartingPosistion) -> Vector2:
	var enemy_direction: Vector2 = (planets[randomPlanet].position - enemyStartingPosistion).normalized()
	return enemy_direction
	
	
func get_random_position_on_camera_edge() -> Vector2:
	var camera_position = camera_2d.position
	var camera_zoom = camera_2d.zoom
	var viewport_size = get_viewport().get_visible_rect().size / camera_zoom
	var visible_rect_top_left = camera_position - viewport_size * 0.5
	var visible_rect_bottom_right = camera_position + viewport_size * 0.5
	var position = Vector2()
	
	# Randomly choose one of the four edges (left, right, top, bottom)
	var edge = randi() % 4
	
	match edge:
		0:  # Left edge
			position.x = visible_rect_top_left.x - 500
			position.y = randf_range(visible_rect_top_left.y, visible_rect_bottom_right.y) 
		1:  # Right edge
			position.x = visible_rect_bottom_right.x + 500
			position.y = randf_range(visible_rect_top_left.y, visible_rect_bottom_right.y)
		2:  # Top edge
			position.x = randf_range(visible_rect_top_left.x, visible_rect_bottom_right.x)
			position.y = visible_rect_top_left.y - 500
		3:  # Bottom edge
			position.x = randf_range(visible_rect_top_left.x, visible_rect_bottom_right.x)
			position.y = visible_rect_bottom_right.y + 500
	return position	
	
func triggerUpgrade() -> void:
	GameManager.add_points(5)
	upgrade.show()
	get_tree().paused = true
	
func _on_add_life_pressed() -> void:
	get_tree().paused = false
	GameManager.lives += 1
	GameManager.add_points(5)
	upgrade.hide()


func _on_add_bullet_speed_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.BULLET_SPEED += 50
	GameManager.add_points(5)



func _on_increase_fire_rate_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.time_between_shots -= 0.15
	GameManager.add_points(5)

	

func _on_increase_bullet_life_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.bullet_lifespan += 0.5
	GameManager.add_points(5)


func _on_decrease_enemy_speed_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.enemy_speed_max -= 5
	GameManager.enemy_speed_min -= 5
	GameManager.add_points(5)
		

func _on_decrease_enemy_spawn_time_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.enemy_spawn_time += 0.05
	GameManager.add_points(5)
	
func _on_get_points_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.add_points(60)


func _on_nothing_happens_pressed() -> void:
	get_tree().paused = false
	upgrade.hide()
	GameManager.add_points(5)


func _on_gamble_for_win_pressed() -> void:
	var rolledNumber = randi_range(0,100)
	if rolledNumber == 42:
		upgrade.hide()
		win.show()
	else:
		get_tree().paused = false
		upgrade.hide()
		GameManager.add_points(5)


func _on_win_button_pressed() -> void:
	OS.kill(OS.get_process_id())


func _on_game_over_pressed() -> void:
	get_tree().paused = false
	GameManager.resetGameStats()
	for node in get_tree().get_nodes_in_group("enemy"):
		node.free()
	get_tree().reload_current_scene()


func _on_mute_pressed() -> void:
	if(AudioServer.is_bus_mute(0)):		
		AudioServer.set_bus_mute(0,false)
	else:
		AudioServer.set_bus_mute(0,true)


func _on_lets_go_pressed() -> void:
	instructions.hide()
	get_tree().paused = false
