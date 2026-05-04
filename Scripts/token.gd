class_name Token
extends Node2D

signal token_selected(tokenId: int)

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var status_effect_sprite = $StatusEffect
@export var token_data: TokenData

func _ready() -> void:
	print(token_data.name)
	self.apply_scale(Vector2(0.5, 0.5))
	sprite.texture = token_data.sprite
	collision.shape.size = token_data.sprite.get_size()
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			print("selected token with instance id: " + str(self.get_instance_id()))
			token_selected.emit(self.get_instance_id())

func show_status_effect(status_effect_name: String):
	var color : Color
	match status_effect_name:
		"Blinded":
			color = Color.CORAL
		"Charmed":
			color = Color.ALICE_BLUE
		"Deafened":
			color = Color.CYAN
		"Frightened":
			color = Color.CORNFLOWER_BLUE
		"Grappled":
			color = Color.DARK_OLIVE_GREEN
		"Incapacitated":
			color = Color.DARK_SLATE_GRAY
		"Invisible":
			color = Color.DARK_SLATE_BLUE
		"Paralyzed":
			color = Color.DARK_RED
		"Petrified":
			color = Color.DARK_ORANGE
		"Poisoned":
			color = Color.DODGER_BLUE
		"Prone":
			color = Color.DARK_KHAKI
		"Restrained":
			color = Color.AZURE
		"Stunned":
			color = Color.CADET_BLUE
		"Unconscious":
			color = Color.DARK_SALMON
		"Exhaustion":
			color = Color.PALE_VIOLET_RED
		_:
			# this is how you clear the effect
			color = Color(0, 0, 0, 0)

	status_effect_sprite.visible = true
	status_effect_sprite.self_modulate = color
