extends CharacterBody2D
class_name Player

const Tv = preload("res://world/tv.gd")

@onready var ray: RayCast2D = $MoveDirectionRay
@onready var gstate := GState
@onready var audio_anims := $AnimationPlayer

const LEFT = Vector2.LEFT * 16
const RIGHT = Vector2.RIGHT * 16
const UP = Vector2.UP * 16
const DOWN = Vector2.DOWN * 16


func _unhandled_input(_event):
	if gstate.textbox_open:
		return  # input handling should be inside the textbox if textbox is open

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
		if direction != Vector2.ZERO:
			global_position += direction
			audio_anims.play("step")


func handle_collision(collider: Object, relative_position_of_object: Vector2) -> void:
	var _normalized_direction := relative_position_of_object.normalized()

	if not collider.has_meta("custom_type"):
		prints("WARNING:", "missing meta data custom_type on object", collider)
		return

	match collider.get_meta("custom_type"):
		"tv":
			gstate.open_textbox("tv-from-left")
		"sofa":
			gstate.open_textbox("sofa")
		_:
			prints(
				"WARNING:",
				collider.get_meta("custom_type"),
				"is missing a case in the collision handler of the Player"
			)
