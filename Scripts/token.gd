extends Node2D

signal token_selected(token: Node2D)

func _ready() -> void:
	print(self.name)
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			token_selected.emit(self)
