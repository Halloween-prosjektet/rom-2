extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("Off")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		sprite.play("On")

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		sprite.play("Off")
