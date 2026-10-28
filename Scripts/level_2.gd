extends Node2D

@onready var plate = get_node_or_null("PressurePlateGreen2")
@onready var trigger: Area2D = get_node_or_null("Room3Trigger")
@onready var inside: Area2D = get_node_or_null("Room3Inside")
@onready var rom3: Sprite2D = get_node_or_null("Rom3")
@onready var barrier_shape: CollisionShape2D = get_node_or_null("Room3Barrier/CollisionShape2D")
@onready var room2_map: Sprite2D = get_node_or_null("Rommedroedpad")
@onready var spawn: Marker2D = get_node_or_null("Room3Spawn")

const ROOM3_OFFSET := Vector2(0, -20)  # 20px above the marker (negative y is up)
const ROOM2_RETURN_OFFSET := Vector2(0, 40)  # px down when returning (positive y is down)

var plate_pressed := false
var revealed := false
var returned_from_room3 := false

func _ready() -> void:
	if plate == null or trigger == null or inside == null or rom3 == null or barrier_shape == null or room2_map == null or spawn == null:
		push_error("level_2.gd: missing node. plate=%s trigger=%s inside=%s rom3=%s barrier=%s map=%s spawn=%s" % [plate, trigger, inside, rom3, barrier_shape, room2_map, spawn])
		return
	plate.pressed.connect(_on_plate_pressed)
	trigger.body_entered.connect(_on_trigger_body_entered)
	trigger.body_exited.connect(_on_trigger_body_exited)
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

# Reset only after the player has returned from Room 3 AND walked clear of the barrier.
func _on_trigger_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and revealed and returned_from_room3:
		_reset_puzzle()

func _teleport_to_room3(body: Node2D) -> void:
	# The sprite is offset from the Player's origin, so cancel that out
	var sprite: Node2D = body.get_node("AnimatedSprite2D")
	var body_offset: Vector2 = sprite.global_position - body.global_position
	body.set_deferred("global_position", spawn.global_position + ROOM3_OFFSET - body_offset)

func _on_inside_body_entered(body: Node2D) -> void:
	if revealed and body.is_in_group("Player"):
		returned_from_room3 = false
		_set_room2_visible(false)

func _on_inside_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_set_room2_visible(true)
		if revealed:
			returned_from_room3 = true
			body.set_deferred("global_position", body.global_position + ROOM2_RETURN_OFFSET)

func _reset_puzzle() -> void:
	plate_pressed = false
	revealed = false
	returned_from_room3 = false
	rom3.visible = false
	barrier_shape.set_deferred("disabled", false)

func _set_room2_visible(show_room: bool) -> void:
	room2_map.visible = show_room
	plate.visible = show_room
