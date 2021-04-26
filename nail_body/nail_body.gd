extends RigidBody2D

export (Texture) var _HealthyNail: Texture
export (Texture) var _BrokenNail: Texture


func reset() -> void:
	$Nail.texture = _HealthyNail
	

func die() -> void:
	$Nail.texture = _BrokenNail
