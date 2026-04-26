extends Button

signal token_data_selected(data: TokenData)

@export var data: TokenData

func _ready():
	self.text = "Click me"
	self.pressed.connect(_button_pressed)

func _button_pressed():
	print("button to select token: " + data.name)
	token_data_selected.emit(data)
