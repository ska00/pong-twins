extends CanvasLayer

signal player_won(winner)

var instruction_index = 0
var player1_score = 0
var player2_score = 0

const WINNING_SCORE = 10
const INSTRUCTIONS = [
	"Each player has two paddles to defend two edges",
	"Player 1 moves with the WASD keys",
	"Player 2 moves with the up. down, left, and right keys",
	"Try moving the paddles!",
	"Whoever scores 10 first wins. Press Enter to start",
]

func _ready():
	$Message.text = "Welcome to a game of Pong!"
	
	

func _process(delta):
	$FPSCounter.text = "FPS: " + str(Engine.get_frames_per_second())

func reset():
	player1_score = 0
	player2_score = 0
	print_scores()
	
	$Message.text = "Press [enter] to start game!"
	$Player1Score.show()
	$Player2Score.show()
	
	
func print_scores():
	$Player1Score.text = str(player1_score)
	$Player2Score.text = str(player2_score)

func print_serve(winner):
	print(winner)
	if winner == "Player1":
		$Message.text = "Player 2 serves"
	else:
		$Message.text = "Player 1 serves"

func update_score(winner: String):
	if winner == "Player1":
		player1_score += 1
		$Message.text = "Player 2 serves"
	else:
		player2_score += 1
		$Message.text = "Player 1 serves"
	
	if player1_score >= WINNING_SCORE:
		player_won.emit("Player1")
	elif player2_score >= WINNING_SCORE:
		player_won.emit("Player2")
		
	
	print_scores()


func _on_player_won(winner: Variant) -> void:
	$Message.text = winner + " won!"
	$Player1Score.hide()
	$Player2Score.hide()


func next_instruction():
	$Message.text = INSTRUCTIONS[instruction_index]
	instruction_index += 1
	if instruction_index >= INSTRUCTIONS.size():
		return -1
