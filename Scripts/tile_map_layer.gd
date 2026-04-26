extends TileMapLayer

var token_tempalte = preload("res://Entities/token.tscn")
var token_data: TokenData

func _unhandled_input(event: InputEvent) -> void:
	move_selected_to_target_cell(event)

# selected = token, cell = grid cell
func move_selected_to_target_cell(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			var cell : Vector2i = self.local_to_map((self as Node2D).to_local(event.position))
			
			# only transfer if there is a grid there
			if self.get_cell_source_id(cell) == -1:
				return
				
			print(cell)
			
			# two separate things: spawning and moving
			if token_data == null:
				return
			
			spawn_token(cell)

# ===== Moving Tokens =====


			
# ===== New Tokens =====

func spawn_token(position: Vector2i) -> void:
	var token = token_tempalte.instantiate()
	token.position = self.map_to_local(position)
	add_child(token)
	
	token_data = null

func _on_button_token_data_selected(data: TokenData) -> void:
	token_data = data
