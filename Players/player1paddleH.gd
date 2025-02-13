extends Area2D

const SPEED = 200.0
const ID = "H"
const PLAYER = 1
var screen_size
var player_size

# Our _init function
func _ready():
	screen_size = get_viewport_rect().size
	player_size = $CollisionShapeH.shape.get_rect().size

# Out _update function
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("player1_right"):
		velocity.x += SPEED
	elif Input.is_action_pressed("player1_left"):
		velocity.x -= SPEED
	
	position += velocity * delta
	position = position.clamp(player_size / 2, screen_size - player_size / 2)

	
