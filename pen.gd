extends Node3D

@onready
var start_height = $Body.position.y

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Body.position.y = start_height - event.pressure * 0.02
		rotation_degrees.x = event.tilt.x * 90
		rotation_degrees.y = event.tilt.y * 90

		$PressureLabel.text = "Pressure: %.2f" % event.pressure
		$TiltLabel.text = "Tilt: [%.2f, %.2f]" % [event.tilt.x, event.tilt.y]
