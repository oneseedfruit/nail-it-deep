extends Node2D

signal hammered

var _is_hammering: bool = false
var _is_stopped: bool = false


func reset() -> void:
	_is_hammering = false
	_is_stopped = false
	$AnimationPlayer.playback_speed = 1
	
	
func stop() -> void:
	reset()
	$AnimationPlayer.stop()
	_is_stopped = true


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.is_pressed() and not _is_stopped:			
			_is_hammering = true


func _process(delta: float) -> void:
	if not _is_stopped and _is_hammering:
		$AnimationPlayer.play("hammering")
	if $AnimationPlayer.playback_speed < 500:
		$AnimationPlayer.playback_speed += 0.018


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("hammered")
	$AudioStreamPlayer2D.play()


func _on_Timer_timeout() -> void:
	if $AnimationPlayer.playback_speed > 1:
		$AnimationPlayer.playback_speed -= 0.1
