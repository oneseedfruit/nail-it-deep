extends Node2D

export (PackedScene) var _PlateScene: PackedScene

var _is_ready: bool = false
var _is_game_over: bool = false
var _game_started: bool = false
var _last_pos: Vector2

var _depth: int = 0


func _ready() -> void:
	_last_pos = $MainCamera.global_position
	$MainCamera/CanvasLayer/StartLabel.show()
	$MainCamera/CanvasLayer/GameOverLabel.hide()
	$MainCamera/CanvasLayer/DepthLabel.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if _is_game_over and _is_ready:			
			get_tree().reload_current_scene()
			
		if _is_ready:
			_game_started = true
			$MainCamera/CanvasLayer/StartLabel.hide()
			$MainCamera/CanvasLayer/DepthLabel.show()
			_is_ready = false			


func _process(delta: float) -> void:
	$MainCamera.global_position = $HammeredNail.global_position + Vector2(0, 50)
	
	if $MainCamera.global_position.y - _last_pos.y > rand_range(50, 80):
		var plate: RigidBody2D = _PlateScene.instance()
		add_child(plate)
		randomize()
		
		var left: float = $MainCamera.global_position.x - 400
		var right: float = $MainCamera.global_position.x + 400
				
		plate.rotation_degrees = rand_range(0, 360)
		plate.global_position.x = rand_range(left, right)		
		plate.global_position.y = $MainCamera.global_position.y + 500
		_last_pos = $MainCamera.global_position
		
		if randf() < 0.5:
			plate.apply_impulse(Vector2.ZERO, Vector2(rand_range(-500, 500), rand_range(-100, 100)))
			plate.angular_velocity = rand_range(-10, 10)
		
		_depth += 1
		$MainCamera/CanvasLayer/DepthLabel.text = str(_depth) + " m"


func _on_HammeredNail_nail_died() -> void:
	$MainCamera/CanvasLayer/GameOverLabel.show()
	_is_game_over = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	_is_ready = true
