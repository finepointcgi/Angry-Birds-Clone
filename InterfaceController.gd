extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func SetScore():
	$InterfaceController/ScoreValue.text = str(int(GameManager.Score))

func PopupLevelCompleted(win,score):
	$Popup/ScoreValue.text = str(int(score))
	if win:
		$Popup/WinLose.text = "You Won!"
		if score > 20:
			$Popup/Star1.show()
			$Tween.interpolate_property($Popup/Star1,"rect_size",Vector2(0,0),Vector2(85,85),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		if score > 50:
			$Popup/Star2.show()
			$Tween.interpolate_property($Popup/Star2,"rect_size",Vector2(0,0),Vector2(85,85),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		if score > 100:
			$Popup/Star3.show()
			$Tween.interpolate_property($Popup/Star3,"rect_size",Vector2(0,0),Vector2(85,85),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		$Popup/WinLose.text = "You Lost!"
	
	$Popup.show()


func _on_NextLevelButton_button_down():
	GameManager.LoadNextLevel()
	pass # Replace with function body.


func _on_RestartLevelButton_button_down():
	GameManager.RestartLevel()
	pass # Replace with function body.
