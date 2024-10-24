extends Fitment


## 获得这个fitment时
func activate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier_intelligently("buying_price").add_new_value(
		ModifierValue.create_new_modifier_value(
			"讨价还价", ModifierValue.Type.MULTIPLY, -0.05
		)
	)

## 丢失这个fitment时
func deactivate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("buying_price").remove_value(
		"讨价还价"
		)
