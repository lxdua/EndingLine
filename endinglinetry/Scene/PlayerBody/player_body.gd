extends CharacterBody3D
class_name PlayerBody

const ACCELERATION: = 40.0
const SPEED: = 4.0

var target: Array[Interaction]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print(target)
		if not target.is_empty():
			target.back().interact(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION * delta)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		velocity.z = move_toward(velocity.z, 0, ACCELERATION * delta)
	move_and_slide()


func _on_player_body_area_area_entered(area: Area3D) -> void:
	print(area)
	if area is Interaction:
		target.append(area)

func _on_player_body_area_area_exited(area: Area3D) -> void:
	print(area)
	if area is Interaction:
		target.erase(area)
