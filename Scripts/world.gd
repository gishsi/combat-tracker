extends Node2D

@onready var modeIndicatorRect = $ColorRect

func _on_add_tokens_button_pressed() -> void:
	modeIndicatorRect.color = Color.CORNFLOWER_BLUE

func _on_move_tokens_button_pressed() -> void:
	modeIndicatorRect.color = Color.MEDIUM_SEA_GREEN
