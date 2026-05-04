extends Button

signal token_removed(token_id: int)

var token_to_remove_id : int

func _pressed() -> void:
	print("will remove token: " + str(token_to_remove_id))
	
	token_removed.emit(token_to_remove_id)
