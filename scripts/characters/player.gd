extends CharacterBody2D
class_name Player

@export var SPEED = 50.0
@export var walk_speed = 50
@export var life = 100
@export var bullet_sword_scene: PackedScene
@export var bullet_thor_scene: PackedScene

var anim_idle_up = "idle_up"
var anim_idle_down = "idle_down"
var anim_idle_left = "idle_left"
var anim_idle_right = "idle_right"

var anim_walk_up = "walk_up"
var anim_walk_down = "walk_down"
var anim_walk_left = "walk_left"
var anim_walk_right = "walk_right"

var last_direction = Vector2.ZERO
var direction_player: Vector2

func _ready() -> void:
	$ProgressBar.value = life

func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#print('espacio')
		#create_bullet()
	pass

func _physics_process(_delta: float) -> void:
	var input_direction = Vector2.ZERO    
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1
	input_direction = input_direction.normalized()
	# Si hay movimiento, aplicamos el movimiento y seleccionamos la animación correcta
	if input_direction != Vector2.ZERO:
		last_direction = input_direction
		velocity = input_direction * walk_speed        
		if input_direction.x > 0:
			$AnimatedSprite2D.animation = anim_walk_right
		elif input_direction.x < 0:
			$AnimatedSprite2D.animation = anim_walk_left
		elif input_direction.y > 0:
			$AnimatedSprite2D.animation = anim_walk_down
		elif input_direction.y < 0:
			$AnimatedSprite2D.animation = anim_walk_up
	else:
		# Si no hay movimiento, cambia a la animación idle según la última dirección
		velocity = Vector2.ZERO        
		if last_direction.x > 0:
			$AnimatedSprite2D.animation = anim_idle_right
		elif last_direction.x < 0:
			$AnimatedSprite2D.animation = anim_idle_left
		elif last_direction.y > 0:
			$AnimatedSprite2D.animation = anim_idle_down
		elif last_direction.y < 0:
			$AnimatedSprite2D.animation = anim_idle_up
	# Mover al CharacterBody2D
	move_and_slide()
	
func decrease_life(value):
	life -= value
	$ProgressBar.value = life
	if life == 0:
		death()

func death():
	print('me morisí')

# Alternativa #2: Esto nos sirve para destruir todo lo que esté fuera de este rango
func _on_limit_enemy_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		area.queue_free()
		print('enemigo eliminado por salir de los límites del player')

func create_bullet_sword():
	var bullet = bullet_sword_scene.instantiate()
	bullet.position = position
	bullet.direction_player = direction_player
	get_parent().add_child(bullet)

func _on_timer_sworm_arm_timeout() -> void:
	create_bullet_sword()

func create_bullet_thor():
	var bullet = bullet_thor_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)

func _on_timer_thor_arm_timeout() -> void:
	create_bullet_thor()
