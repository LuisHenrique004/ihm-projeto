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
	var item = inventory.items[item_index]
	if item is Item:
		var data = {}
		data.item = item
		data.swap = false
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		dragPreview.expand = true
		dragPreview.rect_size = Vector2(16, 16)
		dragPreview.rect_position = get_global_mouse_position() - dragPreview.texture.get_size() / 2
		set_drag_preview(dragPreview)
		return data
		
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
