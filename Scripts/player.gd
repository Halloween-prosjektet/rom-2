extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
var last_direction : Vector2 = Vector2.RIGHT

#	dette er det som runner functions.
func _physics_process(delta: float) -> void:
	
	movements()
	process_anime()
	
	move_and_slide()




""" Så her er starten av movement på karakteren"""
func movements() -> void: 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right","up","down")
	
	if direction != Vector2.ZERO:

		velocity = direction * SPEED
		last_direction = direction
	else: 
		velocity = Vector2.ZERO


func process_anime() -> void:
	if velocity != Vector2.ZERO:
		player_anime("Run", last_direction)
	else: 
		player_anime("Idle", last_direction)

# Rnning animation
func player_anime(prefix: String, dir: Vector2) -> void:
	
	if dir.x != 0:
		#for left and right
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		#for up
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		#for down
		animated_sprite_2d.play(prefix +"_down")
#NOTE 
""" Så her er slutten av movement på karakteren"""
