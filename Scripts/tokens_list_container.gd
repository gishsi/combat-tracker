extends VBoxContainer

@export var tokens: Array[TokenData]
@onready var tokenButtonTemplate = preload("res://Entities/token_button.tscn")

signal token_selection_button_pressed(tokenData: TokenData)

func _ready() -> void:
	for token in tokens:
		var instance = tokenButtonTemplate.instantiate()
		instance.data = token
		instance.token_data_selected.connect(on_token_select_button_pressed)
		
		add_child(instance)

func on_token_select_button_pressed(data: TokenData) -> void:
	token_selection_button_pressed.emit(data)
