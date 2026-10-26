extends Node2D

@onready var plate = get_node_or_null("PressurePlateGreen")
@onready var trigger: Area2D = get_node_or_null("Room3Trigger")
@onready var rom3: Sprite2D = get_node_or_null("Rom3")
@onready var barrier_shape: CollisionShape2D = get_node_or_null("Room3Barrier/CollisionShape2D")

var plate_pressed := false
var revealed := false

func _ready() -> void:
	if plate == null or trigger == null or rom3 == null or barrier_shape == null:
		push_error("level_2.gd: missing node. plate=%s trigger=%s rom3=%s barrier=%s" % [plate, trigger, rom3, barrier_shape])
		return
	plate.pressed.connect(_on_plate_pressed)
	trigger.body_entered.connect(_on_trigger_body_entered)

func _on_plate_pressed() -> void:
	plate_pressed = true

func _on_trigger_body_entered(body: Node2D) -> void:
	if revealed or not plate_pressed:
		return
	if body.is_in_group("Player"):
		revealed = true
		rom3.visible = true
		barrier_shape.set_deferred("disabled", true)
