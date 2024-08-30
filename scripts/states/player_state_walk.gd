extends PlayerState

func enter():
	print('State Walk | Direction: ' + player.current_direction._name)

func process(_delta):
	if Input.is_action_pressed('ui_accept'):
		state_machine.change_to(player.states._idle)
	move_4_directions()

func set_action_direction():
	if Input.is_action_pressed('ui_right'):
		set_current_direction(player.directions.right)
		play_animation(player.animations.walk_right)
	
	elif Input.is_action_pressed('ui_left'):
		set_current_direction(player.directions.left)
		play_animation(player.animations.walk_left)
	
	elif Input.is_action_pressed('ui_up'):
		set_current_direction(player.directions.up)
		play_animation(player.animations.walk_up)
	
	elif Input.is_action_pressed('ui_down'):
		set_current_direction(player.directions.down)
		play_animation(player.animations.walk_down)
	else:
		state_machine.change_to('PlayerStateIdle')

func move_4_directions():
	set_action_direction()
	player.urm_2d.direction_2d = player.current_direction._vector_2d
	player.urm_2d.move()
