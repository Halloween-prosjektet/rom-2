extends Node2D

@onready var plate = get_node_or_null("PressurePlateGreen")
@onready var trigger: Area2D = get_node_or_null("Room3Trigger")
@onready var inside: Area2D = get_node_or_null("Room3Inside")
@onready var rom3: Sprite2D = get_node_or_null("Rom3")
@onready var barrier_shape: CollisionShape2D = get_node_or_null("Room3Barrier/CollisionShape2D")
@onready var room2_map: Sprite2D = get_node_or_null("Rommedroedpad")
@onready var spawn: Marker2D = get_node_or_null("Room3Spawn")

const ROOM3_OFFSET := Vector2(0, -20)  # 20px above the marker (negative y is up)
const ROOM2_RETURN_OFFSET := Vector2(0, 40)  # 10px down (positive y is down)

var plate_pressed := false
var revealed := false

func _ready() -> void:
	if plate == null or trigger == null or inside == null or rom3 == null or barrier_shape == null or room2_map == null or spawn == null:
		push_error("level_2.gd: missing node. plate=%s trigger=%s inside=%s rom3=%s barrier=%s map=%s spawn=%s" % [plate, trigger, inside, rom3, barrier_shape, room2_map, spawn])
		return
	plate.pressed.connect(_on_plate_pressed)
	trigger.body_entered.connect(_on_trigger_body_entered)
	inside.body_entered.connect(_on_inside_body_entered)
	inside.body_exited.connect(_on_inside_body_exited)

func _on_plate_pressed() -> void:
	plate_pressed = true

func _on_trigger_body_entered(body: Node2D) -> void:
	if revealed or not plate_pressed:
		return
	if body.is_in_group("Player"):
		revealed = true
		rom3.visible = true
		barrier_shape.set_deferred("disabled", true)
		_teleport_to_room3(body)

func _teleport_to_room3(body: Node2D) -> void:
	# The sprite is offset from the Player's origin, so cancel that out
	var sprite: Node2D = body.get_node("AnimatedSprite2D")
	var body_offset: Vector2 = sprite.global_position - body.global_position
	body.set_deferred("global_position", spawn.global_position + ROOM3_OFFSET - body_offset)

func _on_inside_body_entered(body: Node2D) -> void:
	if revealed and body.is_in_group("Player"):
		_set_room2_visible(false)

func _on_inside_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_set_room2_visible(true)
		if revealed:
			body.set_deferred("global_position", body.global_position + ROOM2_RETURN_OFFSET)
			_reset_puzzle()

func _reset_puzzle() -> void:
	plate_pressed = false
	revealed = false
	rom3.visible = false
	barrier_shape.set_deferred("disabled", false)

func _set_room2_visible(show_room: bool) -> void:
	room2_map.visible = show_room
	plate.visible = show_room
