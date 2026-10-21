extends Area2D
 
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
 
func _ready() -> void:
	print("Plate ready")
	sprite.play("Off")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
 
func _on_body_entered(body: Node2D) -> void:
	print("entered: ", body.name, " groups: ", body.get_groups())
	if body.is_in_group("player"):
		sprite.play("on")
 
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		sprite.play("off")
