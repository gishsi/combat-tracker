extends Button

signal status_applied(token_id: int)

var token_id : int

func _pressed() -> void:
	print("will apply status to token: " + str(token_id))
	
	status_applied.emit(token_id)
