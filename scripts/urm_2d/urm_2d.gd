extends Node
## Uniform Rectilinear Motion 2D
## Version 1.1
class_name URM2D

@export var speed:float = 100
@export var direction_2d:Vector2 = Vector2.ZERO
@export var normalized:bool = true
@export var character:CharacterBody2D
@export var can_move:bool = true

func _ready() -> void:
	pass

func get_velocity() -> Vector2:
	if normalized:
		direction_2d = direction_2d.normalized()
	#print(direction_2d)
	return direction_2d * speed

func move():
	if can_move:
		character.velocity = get_velocity()
		character.move_and_slide()
	else:
		character.velocity = Vector2.ZERO

func stop_movement(_can_move:bool = false):
	can_move = _can_move
