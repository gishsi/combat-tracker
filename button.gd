extends Button

signal token_data_selected(data: TokenData)

@export var data: TokenData

func _ready():
	self.text = data.name
	self.pressed.connect(_button_pressed)
	self.icon = data.sprite

func _button_pressed():
	token_data_selected.emit(data)
