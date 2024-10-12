extends TextureRect

signal health_button_pressed
@export var health_animated_sprite: AnimatedSprite2D
func _on_health_button_pressed() -> void:
	health_button_pressed.emit()
func _on_health_button_mouse_entered() -> void:
	health_animated_sprite.play("normal")
func _on_health_button_mouse_exited() -> void:
	health_animated_sprite.play_backwards("normal")

signal route_selection_button_pressed
@export var route_selection_animated_sprite: AnimatedSprite2D
func _on_route_selection_button_pressed() -> void:
	route_selection_button_pressed.emit()
func _on_route_selection_button_mouse_entered() -> void:
	route_selection_animated_sprite.play("normal")
func _on_route_selection_button_mouse_exited() -> void:
	route_selection_animated_sprite.play_backwards("normal")

signal train_stats_button_pressed
@export var train_stats_animated_sprite: AnimatedSprite2D
func _on_train_stats_button_pressed() -> void:
	train_stats_button_pressed.emit()
func _on_train_stats_button_mouse_entered() -> void:
	train_stats_animated_sprite.play("normal")
func _on_train_stats_button_mouse_exited() -> void:
	train_stats_animated_sprite.play_backwards("normal")
