extends CharacterBody2D
class_name Player

const Tv = preload("res://world/tv.gd")

@onready var ray: RayCast2D = $MoveDirectionRay
@onready var eventbus := Eventbus

const LEFT = Vector2.LEFT * 16
const RIGHT = Vector2.RIGHT * 16
const UP = Vector2.UP * 16
const DOWN = Vector2.DOWN * 16


func _unhandled_input(_event):
	var direction := Vector2.ZERO
	if Input.is_action_just_pressed("move_left"):
		direction = LEFT
	if Input.is_action_just_pressed("move_right"):
		direction = RIGHT
	if Input.is_action_just_pressed("move_up"):
		direction = UP
	if Input.is_action_just_pressed("move_down"):
		direction = DOWN

	ray.target_position = direction
	ray.force_raycast_update()
	if ray.is_colliding():
		handle_collision(ray.get_collider(), ray.target_position)
	else:
		global_position += direction


func handle_collision(collider: Object, relative_position_of_object: Vector2) -> void:
	print(collider)
	var normalized_direction := relative_position_of_object.normalized()

	print(collider.get_meta_list())
	if not collider.has_meta("custom_type"):
		prints("WARNING:", "missing meta data custom_type on object", collider)
		return

	match collider.get_meta("custom_type"):
		"tv":
			prints(
				"colliding with the Tv. Tv is at ",
				normalized_direction,
				"(normalized) from the player"
			)
			eventbus.show_textbox.emit()
		_:
			prints(
				"WARNING:",
				collider.get_meta("custom_type"),
				"is missing a case in the collision handler of the Player"
			)
