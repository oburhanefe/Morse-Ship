extends TileMapLayer

var light = preload("res://Scenes/light.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for cell in get_used_cells():
			var data = get_cell_tile_data(cell)
			
			if data and data.get_custom_data("light") == true:
				
				var isik = light.instantiate()
				
				isik.position = map_to_local(cell)
				
				add_child(isik)
