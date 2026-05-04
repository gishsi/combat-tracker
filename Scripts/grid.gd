extends Node2D

@onready var tile_map_layer = $TileMapLayer

signal token_content_changed(tokenId: int)

func _ready() -> void:
	tile_map_layer.connect_token.connect(_on_tile_map_layer_connect_token)

func _on_tile_map_layer_connect_token(tokenId: int) -> void:
	print("show content")
	token_content_changed.emit(tokenId)

func _on_remove_token_button_token_removed(token_id: int) -> void:
	tile_map_layer.remove_token(token_id)

func _on_tokens_list_container_token_selection_button_pressed(tokenData: TokenData) -> void:
	tile_map_layer._on_tokens_list_container_token_selection_button_pressed(tokenData)

func _on_add_tokens_button_pressed() -> void:
	tile_map_layer._on_add_tokens_button_pressed()

func _on_move_tokens_button_pressed() -> void:
	tile_map_layer._on_move_tokens_button_pressed()

func _on_apply_status_option_button_status_applied(token_id: int, status_name: String) -> void:
	tile_map_layer.apply_status(token_id, status_name)
