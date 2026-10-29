extends Area2D

@onready var warning_label: Label = $CanvasLayer/Label
@onready var timer: Timer = $Timer

func _ready() -> void:

	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_hide_label)
	
	if warning_label:
		warning_label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("cannot enter")
		
		if warning_label:
			warning_label.visible = true
			

		timer.start()

func _hide_label() -> void:
	if warning_label:
		warning_label.visible = false
