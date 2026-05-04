extends OptionButton

signal status_applied(token_id: int, status_name: String)
var token_id : int

func _on_item_selected(index: int) -> void:
	var text = get_item_text(index)
	
	status_applied.emit(token_id, text)
