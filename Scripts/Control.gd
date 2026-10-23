extends Node2D

var client: ControlRoomClient
var player_name := ""  # spilleren rom 1 sendte over

# --- Level switching (new) ---
@onready var player = $Player
@onready var current_level = $lvl1
var _changing_level := false

var levels = {
	"lvl1": preload("res://Scene/første_lvl.tscn"),
	"lvl2": preload("res://Scene/level_2.tscn"),
}

func _ready() -> void:
	client = ControlRoomClient.new("ws://172.31.0.200:7321", 2)

	var layer := CanvasLayer.new()
	layer.layer = 100  # øverst
	add_child(layer)
	layer.add_child(client)

	# Koble signalene før run(), så ingen blir gått glipp av.
	
	#ta på denne når du skal kjøre spillet på ekte. 
	#client.add_loading_screen()
	client.player_incoming.connect(_on_player_incoming)
	client.player_left.connect(_on_player_left)
	client.game_finish_wait.connect(_on_game_finish_wait)
	client.game_finish_ok.connect(_on_game_finish_ok)
	client.run()

	_connect_doors()  # new

# Rom 1 er ferdig: spilleren er på vei hit.
func _on_player_incoming(username: String, _player_data: Variant) -> void:
	player_name = username
	print("Velkommen til rom 2, ", username)

# Kall denne når spilleren starter spillet (f.eks. trykker Start).
func start_playing() -> void:
	client.start_game()

# Kall denne når spilleren er ferdig i rommet.
func player_won() -> void:
	print("Spilleren er ferdig! Sjekker med kontrollrommet...")
	client.finish_game()

func _on_player_left(username: String) -> void:
	print("Spilleren ", username, " gikk og kommer ikke likevel.")

# Rom 3 er opptatt: be spilleren vente.
func _on_game_finish_wait(max_wait: Variant) -> void:
	print("Neste rom er opptatt. Vent til ", max_wait)

# Spilleren kan gå videre til rom 3.
func _on_game_finish_ok() -> void:
	print("Klart! Spilleren kan gå videre til rom 3.")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		player_won()

# --- Level switching (new) ---
func _connect_doors() -> void:
	for door in get_tree().get_nodes_in_group("doors"):
		if current_level.is_ancestor_of(door) and not door.player_entered.is_connected(_on_door_entered):
			door.player_entered.connect(_on_door_entered)

func _on_door_entered(door) -> void:
	if _changing_level:
		return
	_changing_level = true
	call_deferred("change_level", door.destination_level_tag, door.destination_door_tag)

func change_level(level_tag: String, door_tag: String) -> void:
	if not levels.has(level_tag):
		_changing_level = false
		return

	var old_level = current_level
	current_level = levels[level_tag].instantiate()
	add_child(current_level)
	move_child(current_level, 0)
	if old_level:
		old_level.queue_free()
	_connect_doors()

	for door in get_tree().get_nodes_in_group("doors"):
		if current_level.is_ancestor_of(door) and door.door_tag == door_tag:
			player.global_position = door.spawn.global_position
			door.disable_until_exit()
			break
	_changing_level = false
