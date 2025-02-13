extends Node

var screen_size
var game_state = "intro"
var winner


func _ready() -> void:
	$Player1PaddleV.position = Vector2(16, 60)
	$Player1PaddleH.position = Vector2(40, 243 - 16)
	$Player2PaddleV.position = Vector2(243 - 16, 176)
	$Player2PaddleH.position = Vector2(243 - 16, 16)
	
	
	$HUD/Player1Score.position.x -= 12
	$HUD/Player2Score.position.x += 12


func _process(_delta: float) -> void:
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
	if winner == "Player1":
		$Player2Lose.play()
	else:
		$Player1Lose.play()
	winner = _winner
	$HUD.print_serve(winner)
	game_state = "serve"


func player_won(_winner):
	game_state = "done"
	$WinningSound.play()
	$Ball.hide()
	
