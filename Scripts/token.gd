extends Node2D

@onready var contextMenu = $"Context Menu"

signal token_selected(token: Node2D)

@onready var sprite = $Sprite2D
@export var token_data: TokenData

func _ready() -> void:
	print(token_data.name)
	sprite.texture = token_data.sprite
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			token_selected.emit(self)
			
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			contextMenu.visible = !contextMenu.visible
