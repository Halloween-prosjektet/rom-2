extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0

#	dette er det som runner functions.
func _physics_process(delta: float) -> void:
	
	movements()
	move_and_slide()


func movements() -> void: 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right","up","down")
	velocity = direction * SPEED
	

func player_anime(dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d
