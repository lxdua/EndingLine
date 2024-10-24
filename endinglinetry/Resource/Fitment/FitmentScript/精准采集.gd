extends Fitment


## 获得这个fitment时
func activate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier_intelligently("gather_ability").add_new_value(
		ModifierValue.create_new_modifier_value(
			"精准采集", ModifierValue.Type.ADD, 20
		)
	)

## 丢失这个fitment时
func deactivate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("gather_ability").remove_value(
		"精准采集"
		)
