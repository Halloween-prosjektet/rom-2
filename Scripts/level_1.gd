extends Sprite2D

const FINAL_ROOM_OFFSET := Vector2(0, -20)  # offset from the spawn marker when entering (negative y is up)
const FINAL_ROOM_Return := Vector2(0, 100)   # 30px down when returning

@onready var final_room: Sprite2D = get_node_or_null("Sprite2D")
@onready var warning_door: Area2D = get_node_or_null("CannotEntry2")
@onready var inside: Area2D = get_node_or_null("FinalRoomInside")
@onready var spawn: Marker2D = get_node_or_null("FinalRoomSpawn")

var in_final_room := false
var returned_from_room := false

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
	trigger.body_exited.connect(_on_trigger_body_exited)

func _on_trigger_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or in_final_room:
		return
	
	in_final_room = true
	final_room.visible = true

	var sprite: Node2D = body.get_node("AnimatedSprite2D")
	var body_offset: Vector2 = sprite.global_position - body.global_position
	body.set_deferred("global_position", spawn.global_position + FINAL_ROOM_OFFSET - body_offset)

func _on_trigger_body_exited(body: Node2D) -> void:
	# Only reset the room state once the player has fully walked away from the doorway trigger after returning
	if body.is_in_group("Player") and in_final_room and returned_from_room:
		in_final_room = false
		returned_from_room = false

func _on_inside_body_entered(body: Node2D) -> void:
	if final_room.visible and body.is_in_group("Player"):
		returned_from_room = false
		self_modulate = Color(1, 1, 1, 0)  # hides lvl 1's image, not the final room

func _on_inside_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		self_modulate = Color(1, 1, 1, 1)
		final_room.visible = false
		returned_from_room = true
		
		# Teleport back out safely using your current position + 30px down
		body.set_deferred("global_position", body.global_position + FINAL_ROOM_Return)
