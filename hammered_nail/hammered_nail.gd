extends KinematicBody2D

signal nail_died

var _is_moving: bool = false


func _physics_process(_delta: float) -> void:
	if _is_moving:
		var direction = (global_position - $NailBody.global_position).normalized()
		move_and_slide(direction * 3000)		
		_is_moving = false
		set_physics_process(false)


# warning-ignore:unused_argument
func _process(delta: float) -> void:	
	look_at(get_global_mouse_position())
	rotation -= PI / 2
	rotation_degrees = clamp(rotation_degrees, -70, 70)
	

func _on_Hammering_hammered() -> void:	
	_is_moving = true
	set_physics_process(true)


func _on_NailBody_body_entered(body: Node) -> void:	
	_is_moving = false
	$Hammering.stop()
	$NailBody.die()
	emit_signal("nail_died")
	$AudioStreamPlayer2D.play()
	
