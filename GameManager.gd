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
var hasPoppedUp
var Levels = ["res://MainScene.tscn", "res://Level2.tscn"]
var LevelIndex = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().get_nodes_in_group("InterfaceController")[0].SetScore()
	match CurrentGameState:
		GameState.Start:
			hasPoppedUp = false
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
			if !hasPoppedUp:
				get_tree().get_nodes_in_group("InterfaceController")[0].PopupLevelCompleted(true, Score)
				hasPoppedUp = true
		GameState.Lose:
			if !hasPoppedUp:
				get_tree().get_nodes_in_group("InterfaceController")[0].PopupLevelCompleted(false, Score)
				hasPoppedUp = true
				print("You Lost!")
	pass

func RestartLevel():
	get_tree().change_scene(Levels[LevelIndex])
	ResetGameManager()
	
func LoadNextLevel():
	LevelIndex += 1
	if LevelIndex > Levels.size() - 1:
		LevelIndex = 0
	get_tree().change_scene(Levels[LevelIndex])
	ResetGameManager()

func ResetGameManager():
	CurrentGameState = GameState.Start
	Score = 0
