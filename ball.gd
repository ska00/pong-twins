extends Area2D

signal scored(paddle)

const SPEED_X = 75
const SPEED_Y = 75

var screen_size
var ball_size
var velocity = Vector2.ZERO
var in_motion = false

# The _init function
func _ready() -> void:
	screen_size = get_viewport_rect().size
	ball_size = $CollisionShape2D.shape.get_rect().size
	
	# Position the ball at the center of the window
	position = screen_size / 2

# The _update function
func _process(delta: float) -> void:
	position += velocity * delta


# Reset
func reset(pos = screen_size / 2):
	position = pos
	velocity = Vector2.ZERO

# Start
func start():
	var signs = [-1, 1]
	velocity.x = signs[randi() % signs.size()] * SPEED_X
	velocity.y = randi_range(-SPEED_Y, SPEED_Y)

# Serve
func serve(paddle):
	if paddle == "Player1":
		velocity.x = -SPEED_X
	else:
		velocity.x = SPEED_X
	velocity.y = randi_range(-SPEED_Y, SPEED_Y)
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	if position.x >= screen_size.x or position.y <= 0:
		scored.emit("Player1")
		reset(screen_size / 2 + Vector2(32, 0))
	else:
		scored.emit("Player2")	
		reset(screen_size / 2 - Vector2(32, 0))

func _on_area_entered(area: Area2D) -> void:
	print(area.ID)
	if area.ID == "V":
		velocity.x = -velocity.x * 1.05
		if velocity.y < 0:
			velocity.y = -randi_range(10, 150)
		else:
			velocity.y = randi_range(10, 150)
	else:
		velocity.y = -velocity.y * 1.05
		if velocity.x < 0:
			velocity.x = -randi_range(10, 150)
		else:
			velocity.x = randi_range(10, 150)
