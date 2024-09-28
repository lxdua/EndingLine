extends Node
class_name ModifierHandler

## 是否有修饰器
func has_modifier(modifier_name: String) -> bool:
	for modifier: Modifier in get_children():
		if modifier.modifier_name == modifier_name:
			return true
	return false

## 获取修饰器
func get_modifier(modifier_name: String) -> Modifier:
	for modifier: Modifier in get_children():
		if modifier.modifier_name == modifier_name:
			return modifier
	return null

## 使用修饰器
func get_modifier_result(modifier_name: String, base: float) -> float:
	var modifier: Modifier = get_modifier(modifier_name)
	if not modifier:
		return base
	return modifier.get_modifier_value(base)
