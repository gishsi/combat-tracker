extends TileMapLayer

# Editor modes
var adding_tokens = true;
var moving_tokens = false;

# Tokens
var token_tempalte = preload("res://Entities/token.tscn")
var token_data: TokenData

var movable_token_id : int; # todo: nullable/option pattern

signal connect_token(token: int)

var tracker_grid : TrackerGrid = TrackerGrid.new()

func _ready() -> void:
	self.apply_scale(Vector2(4, 4))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_pos = get_global_mouse_position()
			var position : Vector2i = self.local_to_map((self as Node2D).to_local(mouse_pos))
			
			# only transfer if there is a grid cell there
			if self.get_cell_source_id(position) == -1:
				return
				
			if adding_tokens:
				spawn_token(position)
			elif moving_tokens:
				move_selected_to_target_cell(position)
				
# ===== Moving Tokens =====
# selected = token, cell = grid cell
func move_selected_to_target_cell(targetPosition: Vector2i) -> void:
	if !moving_tokens or movable_token_id == -1:
		return
	
	var movable_token = TokensDataSource.tokens.get(movable_token_id) as Token
	
	if movable_token == null:
		print("cannot move a token without choosing choosing it first.")
		return

	var grid_update_successful = tracker_grid.update_position(targetPosition, movable_token_id)
	
	if !grid_update_successful:
		print("couldn't update the grid, possibly tokens would overlap")
		return
	
	movable_token.position = self.map_to_local(targetPosition)
	movable_token_id = -1

func token_selected_event(tokenId: int):
	connect_token.emit(tokenId)
	
	if !moving_tokens:
		return
		
	movable_token_id = tokenId
	
# ===== New Tokens =====
func spawn_token(position: Vector2i) -> void:
	if !adding_tokens:
		return
		
	if token_data == null:
		return
				
	var token = token_tempalte.instantiate()
	token.name = token_data.name
	token.position = self.map_to_local(position)
	token.token_selected.connect(token_selected_event)
	token.token_data = token_data
		
	var instance_id = token.get_instance_id()
	
	TokensDataSource.tokens.set(token.get_instance_id(), token)
	
	tracker_grid.add(position, instance_id)
	
	add_child(token)
	
	token_data = null

# ===== Signals =====
func _on_add_tokens_button_pressed() -> void:
	adding_tokens = true
	moving_tokens = false

func _on_move_tokens_button_pressed() -> void:
	adding_tokens = false
	moving_tokens = true

func _on_tokens_list_container_token_selection_button_pressed(tokenData: TokenData) -> void:
	token_data = tokenData

func remove_token(token_id: int) -> void:
	if !tracker_grid.exists_by_id(token_id) or !TokensDataSource.tokens.has(token_id):
		return
	
	# hopefully everything goes ok :) todo: error handling here
	TokensDataSource.tokens.erase(token_id)
	tracker_grid.erase_token_by_id(token_id)
	
	var obj = instance_from_id(token_id)
	obj.queue_free()
	
func apply_status(token_id: int, status_effect_name: String) -> void:
	print("applying status to: " + str(token_id))
	
	if !TokensDataSource.tokens.has(token_id):
		return
		
	var token = TokensDataSource.tokens[token_id]
	token.show_status_effect(status_effect_name)
	

	
