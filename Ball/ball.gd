extends Area2D

signal scored(paddle)

const SPEED_X = 75
const SPEED_Y = 75
const DEGREES_OFF = 15
const SCALE = 1.05

var ball_size
var screen_size
var in_motion = false
var velocity = Vector2.ZERO


func _ready():
	ball_size = $CollisionShape2D.shape.get_rect().size
	screen_size = get_viewport_rect().size
	
	# Position the ball at the center of the window
	position = screen_size / 2


func _process(delta: float):
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
	# Play sound of paddle hitting ball
	if area.PLAYER == 1:
		$Player1Hit.play()
	else:
		$Player2Hit.play()
	
	## For the vertical paddles
	#if area.ID == "V":
		#velocity.x = -velocity.x * 1.05
		#velocity.y = sign(velocity.y) * randi_range(10, 150)
	#
	## For the horizontal paddles
	#else:
		#velocity.y = -velocity.y * 1.05
		#velocity.x = sign(velocity.x) * randi_range(10, 150)
	
	
	var degrees = randi_range(90, 125 + DEGREES_OFF) * (PI / 180)
	# For the vertical paddles
	if area.ID == "V" and area.PLAYER == 1:
		if velocity.y > 0:
			velocity = velocity.rotated(-degrees) * SCALE
		else:
			velocity = velocity.rotated(degrees) * SCALE
	elif area.ID == "V" and area.PLAYER == 2:
		if velocity.y > 0:
			velocity = velocity.rotated(degrees) * SCALE
		else:
			velocity = velocity.rotated(-degrees) * SCALE
	
	elif area.ID == "H" and area.PLAYER == 1:
		if velocity.x > 0:
			velocity = velocity.rotated(-degrees) * SCALE
		else:
			velocity = velocity.rotated(degrees) * SCALE
	# For the horizontal paddles
	else:
		if velocity.x > 0:
			velocity = velocity.rotated(degrees) * SCALE
		else:
			velocity = velocity.rotated(-degrees) * SCALE
	
