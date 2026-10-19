extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label = $Label
@onready var panel: Panel = $Panel
@onready var player = get_node("../Player")
const password = "1234"

var regex = RegEx.new()
var old_text: String = ""

func _ready():
	regex.compile("[^0-9]")
	line_edit.text_submitted.connect(user_input)
	line_edit.text_submitted.connect(user_input)
	line_edit.text_changed.connect(_check_user)

func _check_user(new_text: String) -> void:
	if regex.search(new_text):
		var caret_pos = line_edit.caret_column - 1
		line_edit.text = old_text
		line_edit.caret_column = max(0, caret_pos)
		
	else:
		old_text = new_text

func user_input (new_text: String) -> void:
	if new_text == password && new_text.is_valid_int():
		print("ready")
		

		player.enable_movement()
		
		animated_sprite_2d.play("Lock_unlock")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.queue_free()
		line_edit.queue_free()
		panel.queue_free()
	else:
		print("incorrect password")
		animated_sprite_2d.play("Lock_fail")
		line_edit.clear()
		
		
