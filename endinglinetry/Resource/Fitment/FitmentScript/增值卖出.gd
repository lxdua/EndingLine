extends Fitment


## 获得这个fitment时
func activate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier_intelligently("selling_price").add_new_value(
		ModifierValue.create_new_modifier_value(
			"增值卖出", ModifierValue.Type.MULTIPLY, 0.08
		)
	)

## 丢失这个fitment时
func deactivate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("selling_price").remove_value(
		"增值卖出"
		)
