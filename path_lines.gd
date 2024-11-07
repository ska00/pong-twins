extends Node2D

const PLAYER1_COLOR = "00faff86"
const PLAYER2_COLOR = "fffa0086"

var is_shown = false


func _ready() -> void:
	hide()


func _draw():
	# Player 2 Paddle Horizontal
	draw_dashed_line(Vector2(2, 16), Vector2(243 - 2, 16), Color(PLAYER2_COLOR), 1)
	# Player 2 Paddle Vertical
	draw_dashed_line(Vector2(243 - 16, 2), Vector2(243 - 16, 243 - 2), Color(PLAYER2_COLOR), 1)
	# Player 1 Paddle Horizontal
	draw_dashed_line(Vector2(2, 243 - 16), Vector2(243 - 2,243 - 16), Color(PLAYER1_COLOR), 1)
	# Player 1 Paddle Vertical
	draw_dashed_line(Vector2(16, 2), Vector2(16, 243 - 2), Color(PLAYER1_COLOR), 1)


func _on_show_paths_button_pressed() -> void:
	if is_shown:
		hide()
		is_shown = false
	else:
		show()
		is_shown = true
