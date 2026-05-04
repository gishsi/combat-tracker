class_name TrackerGrid extends RefCounted


var positionToIdGrid : Dictionary[Vector2, int] = {}
var idToPositionGrid : Dictionary[int, Vector2] = {}
	
func add(position: Vector2, id: int):
	positionToIdGrid.set(position, id)
	idToPositionGrid.set(id, position)

func erase(position: Vector2, id: int):
	positionToIdGrid.erase(position)
	idToPositionGrid.erase(id)

func update_position(targetPosition: Vector2, id: int) -> bool:
	if positionToIdGrid.has(targetPosition):
		print("cell already taken.")
		return false
	
	var previous_position = idToPositionGrid[id]
	positionToIdGrid.erase(previous_position)
	
	add(targetPosition, id)
	
	return true
	
func exists_by_id(id: int) -> bool:
	return idToPositionGrid.has(id)
	
func erase_token_by_id(id: int):
	if !idToPositionGrid.has(id):
		return
	
	var position = idToPositionGrid[id]
	
	erase(position, id)
