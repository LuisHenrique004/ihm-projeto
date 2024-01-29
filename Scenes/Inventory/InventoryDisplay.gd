extends GridContainer

export (Resource) var inventory
export (Resource) var inputs

var timer = Timer.new()
var steps = 0

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
		_start_time()
	else:
		print("Erro ao obter referência do jogador.")

func _timer_callback():
	var items = inventory.items
	if (steps < items.size() && items[steps] != null):
		var player_ref = get_tree().get_root().get_node("Node2D").get_node("Player")
		player_ref.move(items[steps].name)
		timer.start()
		steps += 1
	else:
		var spot = get_tree().get_root().get_node("Node2D").get_node("Spots").get_node("Spot")
		if spot.occupied:
			print("blz")
		else:
			get_tree().get_root().get_node("Node2D").get_node("AcceptDialog_erro").popup()
			print("falhou")

func _start_time():
	steps = 0
	var player_ref = get_tree().get_root().get_node("Node2D").get_node("Player")
	timer.one_shot = true
	timer.wait_time = 0.5
	timer.connect("timeout", self, "_timer_callback")
	player_ref.add_child(timer)
	timer.start()

	

