extends GridMap


func destroy_block(world_cordinate):
	var map_coordinate = local_to_map(world_cordinate)
	set_cell_item(map_coordinate, -1)


func place_block(world_cordinate, block_index):
	var map_coordinate = local_to_map(world_cordinate)
	set_cell_item(map_coordinate, block_index)
