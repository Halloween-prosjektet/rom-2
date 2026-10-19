extends Area2D

@onready var sprite = $AnimatedSprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	sprite.play("off")

func _on_body_entered(body):
	sprite.play("on")

func _on_body_exited(body):
	sprite.play("off")
