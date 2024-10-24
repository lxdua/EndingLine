extends Fitment


## 获得这个fitment时
func activate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier_intelligently("cave_item_num").add_new_value(
		ModifierValue.create_new_modifier_value(
			"幸运", ModifierValue.Type.MULTIPLY, 0.2
		)
	)

## 丢失这个fitment时
func deactivate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("cave_item_num").remove_value(
		"幸运"
		)
