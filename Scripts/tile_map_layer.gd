extends TileMapLayer

# Editor modes
var adding_tokens = true;
var moving_tokens = false;

# Tokens
var token_tempalte = preload("res://Entities/token.tscn")
var token_data: TokenData

var movable_token: Node2D;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			var position : Vector2i = self.local_to_map((self as Node2D).to_local(event.position))
			
			# only transfer if there is a grid there
			if self.get_cell_source_id(position) == -1:
				return
				
			if adding_tokens:
				spawn_token(position)
			elif moving_tokens:
				move_selected_to_target_cell(position)
				
# ===== Moving Tokens =====
# selected = token, cell = grid cell
func move_selected_to_target_cell(targetPosition: Vector2i) -> void:
	if !moving_tokens:
		return
	
	if movable_token == null:
		print("cannot move a token without choosing choosing it first.")
		return
	
	movable_token.position = self.map_to_local(targetPosition)
	
	# todo: make sure this is a good idea and its not actually removing important data (by ref, or by copy?)
	movable_token = null

func token_selected_event(token: Node2D):
	movable_token = token
	
# ===== New Tokens =====
func spawn_token(position: Vector2i) -> void:
	if !adding_tokens:
		return
		
	if token_data == null:
		print("cannot add a token without choosing token's data first.")
		return
				
	var token = token_tempalte.instantiate()
	token.name = token_data.name
	token.position = self.map_to_local(position)
	add_child(token)
	
	token.token_selected.connect(token_selected_event)
	
	token_data = null

func _on_button_token_data_selected(data: TokenData) -> void:
	token_data = data

func _on_add_tokens_button_pressed() -> void:
	adding_tokens = true
	moving_tokens = false

func _on_move_tokens_button_pressed() -> void:
	adding_tokens = false
	moving_tokens = true
