extends Node2D

enum GameState {
	Start,
	Play,
	Win,
	Lose
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CurrentGameState = GameState.Start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match CurrentGameState:
		GameState.Start:
			pass
		GameState.Play:
			var birds = get_tree().get_nodes_in_group("Bird")
			var pigs = get_tree().get_nodes_in_group("Pigs")
			if pigs.size() <= 0:
				CurrentGameState = GameState.Win
			elif birds.size() <= 0:
				CurrentGameState = GameState.Lose
			pass
		GameState.Win:
			print("You won!")
		GameState.Lose:
			print("You Lost!")
	pass
