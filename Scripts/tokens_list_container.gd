extends VBoxContainer

@export var tokens: Array[TokenData]

@onready var tokenButtonTemplate = preload("res://Entities/token_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# later, this will need a signals reattaching to the grid script or a rework of that 
	#for token in tokens:
		#var instance = tokenButtonTemplate.instantiate()
		#instance.data = token
		#
		#add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
