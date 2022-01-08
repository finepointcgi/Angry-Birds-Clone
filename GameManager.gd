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
var Score = 0
var Levels = ["res://MainScene.tscn","res://Level2.tscn"]
var LevelIndex = 0
var Win
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
			Win = true
			pass
		GameState.Win:
			if Win:
				print(Score)
				get_tree().get_nodes_in_group("InterfaceManager")[0].Popup()
				Win = false
		GameState.Lose:
			if Win:
				get_tree().get_nodes_in_group("InterfaceManager")[0].Popup()
				Win = false
				print("You Lost!")
	pass

func LoadNextLevel():
	LevelIndex += 1
	if LevelIndex > Levels.size() - 1:
		LevelIndex = 0
	get_tree().change_scene(Levels[LevelIndex])

func ResetLevel():
	get_tree().change_scene(Levels[LevelIndex])
