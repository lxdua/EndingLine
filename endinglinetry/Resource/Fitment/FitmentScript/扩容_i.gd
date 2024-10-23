extends Fitment


## 获得这个fitment时
func activate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("max_train_load").add_new_value(
		ModifierValue.create_new_modifier_value(
			"扩容 I", ModifierValue.Type.MULTIPLY, 0.1
		)
	)

## 丢失这个fitment时
func deactivate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("max_train_load").remove_value(
		"扩容 I"
		)
