extends Control

@onready var lbl_count: Label = $lblCount
@onready var animation_count_down: AnimationPlayer = $AnimationCountDown
@onready var audio_number: AudioStreamPlayer = $AudioNumber
@onready var audio_start: AudioStreamPlayer = $AudioStart

@export var auto_start : bool = true
@export var counter_values : Array = [
	{
		"border_color" : Color('6a4698'),
		"value" : "3"
	},
	{
		"border_color" : Color('2da5ff'),
		"value" : "2"
	},
	{
		"border_color" : Color('ff7564'),
		"value" : "1"
	},
	{
		"border_color" : Color('0da4b6'),
		"value" : "GO!"
	}
]

var current_value = 0
var max_counter_values = 0

signal end_countdown()

func _ready() -> void:
	if auto_start:
		start_countdown()
	pass

func _process(_delta: float) -> void:
	if animation_count_down.current_animation == 'countdown':
		center_pivot()
	pass

func start_countdown():
	max_counter_values = counter_values.size() -1
	center_pivot()
	change_values(current_value)
	animation_count_down.play('countdown')

func center_pivot():
	lbl_count.pivot_offset.x = lbl_count.size.x / 2
	lbl_count.pivot_offset.y = lbl_count.size.y / 2

func change_values(index_value : int):
	lbl_count.text = counter_values[index_value].value
	lbl_count.set(
		"theme_override_colors/font_outline_color",
		counter_values[index_value].border_color
	)

func _on_animation_count_down_animation_finished(_anim_name: StringName) -> void:
	next_value()
	pass # Replace with function body.

func next_value():
	if current_value < max_counter_values:
		current_value = current_value + 1
		change_values(current_value)		
		animation_count_down.play('countdown')
	else:
		animation_count_down.stop()
		current_value = 0
		print('Start Game')

func play_sound_count():
	audio_number.play()
	pass

func play_sound_start():
	audio_start.play()
	pass

func _on_animation_count_down_animation_started(_anim_name: StringName) -> void:
	if current_value < max_counter_values:
		play_sound_count()
	else:
		play_sound_start()
		end_countdown.emit()
	pass 
