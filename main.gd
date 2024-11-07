extends Node

var screen_size
var game_state = "intro"
var winner


func _ready() -> void:
	$Player1.position = Vector2(32, 60)
	$Player2.position = Vector2(432 - 32, 176)
	$HUD/Player1Score.position.x -= 32
	$HUD/Player2Score.position.x += 32


func _process(delta: float) -> void:
	if Input.is_action_just_released("exit"):
		get_tree().quit()
	
	if Input.is_action_just_released("start"):
		if game_state == "intro":
			if $HUD.next_instruction() == -1:
				game_state = "start"
		elif game_state == "play":
			$Ball.reset()
			game_state = "start"
		elif game_state == "start":
			$Ball.start()
			game_state = "play"
			$HUD/Message.text = ""
		elif game_state == "serve":
			$Ball.serve(winner)
			game_state = "play"
			$HUD/Message.text = ""
		elif game_state == "done":
			game_state = "start"
			$Ball.reset()
			$Ball.show()
			$HUD.reset()
			
			


func scored(_winner: String):
	winner = _winner
	$HUD.print_serve(winner)
	game_state = "serve"


func player_won(winner):
	game_state = "done"
	$Ball.hide()
	
