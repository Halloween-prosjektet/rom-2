extends Node

var client: ControlRoomClient


func _ready() -> void:
	# Rom nummer er 1 til 5.
	client = ControlRoomClient.new("ws://172.31.0.200:7321", 2)
	add_child(client)
	client.run()
