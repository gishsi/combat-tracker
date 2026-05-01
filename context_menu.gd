extends VBoxContainer

@onready var name_label = $NameLabel

var selected_token: Node2D
var selected_token_data: TokenData

func _on_tile_map_layer_connect_token(token: Node2D) -> void:
	print("context show: " + token.token_data.name)
	selected_token = token
	selected_token_data = token.token_data
	
	set_content()

func set_content():
	name_label.text = selected_token_data.name
