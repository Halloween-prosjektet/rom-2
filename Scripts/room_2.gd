extends Area2D
class_name Door

signal player_entered(door)

@export var door_tag: String
@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"
@export var is_finish: bool = false
@onready var spawn: Marker2D = $spawn

var armed: bool = true

func _ready():
	if has_node("spawn2"):
		spawn = $spawn2
		$CollisionShape2D.position = spawn.position
	add_to_group("doors")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if armed and body.is_in_group("Player"):
		player_entered.emit(self)

func _on_body_exited(body):
	if body.is_in_group("Player"):
		armed = true

func disable_until_exit() -> void:
	armed = false
	
