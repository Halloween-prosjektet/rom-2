extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label = $Label

const password = "Halloween123"


func _ready():
	line_edit.text_submitted.connect(user_input)

func user_input (new_text: String) -> void:

	
	if new_text == password:
		print("ready")
		animated_sprite_2d.play("Lock_unlock")
	else:
		print("incorrect passbroder")
		animated_sprite_2d.play("Lock_fail")

		

		
		line_edit.clear()
		
