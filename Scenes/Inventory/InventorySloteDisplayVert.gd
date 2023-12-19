extends CenterContainer

var inventory = preload("res://InventoryV.tres")

onready var itemTextureRect = $TextureRect

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://items/EmptyInventorySlot.png") 

func get_drag_data(_position):
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		dragPreview.expand = true
		dragPreview.rect_size = Vector2(40, 40)
		dragPreview.rect_position = get_global_mouse_position() - dragPreview.texture.get_size() / 2
		set_drag_preview(dragPreview)
		return data
		
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	inventory.swap_items(my_item_index, data.item_index)
	inventory.set_item(my_item_index, data.item)
