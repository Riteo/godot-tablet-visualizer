extends Node3D

@onready var start_transform : Transform3D = $Eraser.transform
@onready var tip_transform : Transform3D = %Tip.transform

const TIP_PRESSURE_MULTIPLIER := 0.02
const ERASER_RADIUS := 0.1

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var tip_offset : float = event.pressure * TIP_PRESSURE_MULTIPLIER

		if event.pen_inverted:
			# The tip stays always put when upside down.
			%Tip.transform = tip_transform

			# Move the eraser (and thus the whole pen) to the pivot (with the
			# proper offset to not go through the tablet)...
			$Eraser.position.y = ERASER_RADIUS
			# ... and flip everything outside down.
			$Eraser.rotation_degrees.z = 180
		else:
			$Eraser.position.y = start_transform.origin.y - tip_offset
			%Tip.position.y = tip_transform.origin.y + tip_offset

		# This node acts as a pivot, so we just need to tilt it.
		rotation_degrees.x = event.tilt.x * 90
		rotation_degrees.y = event.tilt.y * 90

		$InfoLabel.text = "Pressure: %.2f\nTilt: [%.2f, %.2f]\nEraser: %s" \
			% [event.pressure, event.tilt.x, event.tilt.y, event.pen_inverted]
