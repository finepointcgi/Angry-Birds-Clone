extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ScoreValue
var Star1
var Star2
var Star3
# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreValue = $Control/ScoreValue
	Star1 = $Popup/Star
	Star2 = $Popup/Star2
	Star3 = $Popup/Star3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ScoreValue.text = str(int(GameManager.Score))
	pass

func Popup():
	$Popup.show()
	if GameManager.Score > 500:
		$Tween.interpolate_property(Star1,"rect_size",Vector2(0,0),Vector2(74,74),.5,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	if GameManager.Score > 1000:
		$Tween.interpolate_property(Star2,"rect_size",Vector2(0,0),Vector2(74,74),.5,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	if GameManager.Score > 2000:
		$Tween.interpolate_property(Star3,"rect_size",Vector2(0,0),Vector2(74,74),.5,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()



func _on_Restart_Level_button_down():
	GameManager.ResetLevel()
	pass # Replace with function body.


func _on_Load_Next_Level_button_down():
	GameManager.LoadNextLevel()
	pass # Replace with function body.
