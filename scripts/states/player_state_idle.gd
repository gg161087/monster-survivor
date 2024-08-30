extends PlayerState

func enter():
	print('State Idle | Direction: ' + player.current_direction._name)
	animation_direction()

func process(_delta):
	if Input.is_action_pressed('ui_right'):
		set_current_direction(player.directions.right)
		state_machine.change_to(player.states._walk)
	
	if Input.is_action_pressed('ui_left'):
		set_current_direction(player.directions.left)
		state_machine.change_to(player.states._walk)
	
	if Input.is_action_pressed('ui_up'):
		set_current_direction(player.directions.up)
		state_machine.change_to(player.states._walk)
	
	if Input.is_action_pressed('ui_down'):
		set_current_direction(player.directions.down)
		state_machine.change_to(player.states._walk)
	
func animation_direction():
		match player.current_direction:
			player.directions.left:
				play_animation(player.animations.idle_left)
			player.directions.right:
				play_animation(player.animations.idle_right)
			player.directions.up:
				play_animation(player.animations.idle_up)
			player.directions.down:
				play_animation(player.animations.idle_down)
			_:
				play_animation(player.animations.idle_none)
