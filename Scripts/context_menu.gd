extends VBoxContainer

@onready var name_label = $NameLabel
@onready var remove_token_button = $RemoveTokenButton
@onready var applt_status_option_button = $ApplyStatusOptionButton
var selected_token: Node2D
var selected_token_data: TokenData

func _on_grid_token_content_changed(tokenId: int) -> void:
	print("grid token content changed: " + str(tokenId))

	print(TokensDataSource.tokens)
	if !TokensDataSource.tokens.has(tokenId):
		print("Cannot show context for token, it doens't exist in the data source yet")
		return
	
	print("token id: " + str(tokenId))
	var token = TokensDataSource.tokens.get(tokenId)
	print("context show: " + token.token_data.name)
	selected_token = token
	selected_token_data = token.token_data
	
	remove_token_button.token_to_remove_id = tokenId
	applt_status_option_button.token_id = tokenId
	
	name_label.text = selected_token_data.name
