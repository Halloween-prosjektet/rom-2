extends Area2D
class_name Door

signal player_entered(door: Door)

@export var door_tag: String
@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $spawn

func _ready():
	add_to_group("doors")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_entered.emit(self)
