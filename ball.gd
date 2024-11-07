extends Area2D

signal scored(paddle)

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
	# An alternative is to pull walls and detect collision with them.
	if position.y <= ball_size.y / 2 or position.y >= screen_size.y - ball_size.y / 2:
		velocity.y = - velocity.y


# Reset
func reset(pos = screen_size / 2):
	position = pos
	velocity = Vector2.ZERO

# Start
func start():
	var signs = [-1, 1]
	velocity.x = signs[randi() % signs.size()] * 125
	velocity.y = randi_range(-75, 75)

# Serve
func serve(paddle):
	if paddle == "Player1":
		velocity.x = -125
	else:
		velocity.x = 125
	velocity.y = randi_range(-75, 75)
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	if position.x >= screen_size.x:
		scored.emit("Player1")
		reset(screen_size / 2 + Vector2(32, 0))
	else:
		scored.emit("Player2")	
		reset(screen_size / 2 - Vector2(32, 0))

func _on_area_entered(area: Area2D) -> void:
	velocity.x = -velocity.x * 1.05
	if velocity.y < 0:
		velocity.y = -randi_range(10, 150)
	else:
		velocity.y = randi_range(10, 150)
