extends Fitment


## 获得这个fitment时
func activate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("current_speed").add_new_value(
		ModifierValue.create_new_modifier_value(
			"发动机改进", ModifierValue.Type.MULTIPLY, 0.1
		)
	)

## 丢失这个fitment时
func deactivate():
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
	modifier_handler.get_modifier("current_speed").remove_value(
		"发动机改进"
		)
