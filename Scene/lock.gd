extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



#	dette er det som runner functions.
func _physics_process(delta: float) -> void:
	animated_sprite_2d.play("Lock_unlock")
