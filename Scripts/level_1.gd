extends Sprite2D

const FINAL_ROOM_OFFSET := Vector2(0, -20)  # offset from the spawn marker (negative y is up)

@onready var final_room: Sprite2D = get_node_or_null("Sprite2D")
@onready var warning_door: Area2D = get_node_or_null("CannotEntry2")
@onready var inside: Area2D = get_node_or_null("FinalRoomInside")
@onready var spawn: Marker2D = get_node_or_null("FinalRoomSpawn")

func _ready() -> void:
	if final_room == null or warning_door == null or inside == null or spawn == null:
		push_error("level_1.gd: missing node. room=%s warning=%s inside=%s spawn=%s" % [final_room, warning_door, inside, spawn])
		return
	final_room.visible = false
	inside.body_entered.connect(_on_inside_body_entered)
	inside.body_exited.connect(_on_inside_body_exited)
	if get_parent().get("final_room_unlocked") == true:
		_make_detection_point()

# After the yellow plate: turn off the "Cannot enter" message and put a
# detection point in the same spot.
func _make_detection_point() -> void:
	warning_door.monitoring = false
	var src: CollisionShape2D = warning_door.get_node("CollisionShape2D")
	var trigger := Area2D.new()
	var shape := CollisionShape2D.new()
	shape.shape = src.shape
	shape.position = src.position
	trigger.add_child(shape)
	add_child(trigger)
	trigger.body_entered.connect(_on_trigger_body_entered)

func _on_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	final_room.visible = true
	# The sprite is offset from the Player's origin, so cancel that out
	var sprite: Node2D = body.get_node("AnimatedSprite2D")
	var body_offset: Vector2 = sprite.global_position - body.global_position
	body.set_deferred("global_position", spawn.global_position + FINAL_ROOM_OFFSET - body_offset)

func _on_inside_body_entered(body: Node2D) -> void:
	if final_room.visible and body.is_in_group("Player"):
		self_modulate = Color(1, 1, 1, 0)  # hides lvl 1's image, not the final room

func _on_inside_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		self_modulate = Color(1, 1, 1, 1)
		final_room.visible = false
