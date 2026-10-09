extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label = $Label

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
		animated_sprite_2d.play("Lock_unlock")
		
		animated_sprite_2d.hide("Lock_unlock")
	else:
		print("incorrect passbroder")
		animated_sprite_2d.play("Lock_fail")

		line_edit.clear()
		
