extends GridContainer

export (Resource) var inventory
export (Resource) var inputs

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
	
func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)

func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _on_JogarBnt_pressed():
	var player_ref = get_tree().get_root().get_node("Node2D").get_node("Player")
	if player_ref != null:
		var items = inventory.items
		print("Inventário:", items)
		
		for item in items:
			if item != null and item is Item and item.name in ["ui_up", "ui_down", "ui_left", "ui_right"]:
				print("Item no inventário:", item.name)
				player_ref.move(item.name)
	else:
		print("Erro ao obter referência do jogador.")
