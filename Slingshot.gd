extends Node2D

enum SlingState{
	idle,
	pulling,
	birdThrown,
	reset
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var SlingShotState
var LeftLine
var RightLine
var Player
var CenterOfSlingshot
# Called when the node enters the scene tree for the first time.
func _ready():
	SlingShotState = SlingState.idle
	LeftLine = $LeftLine
	RightLine = $RightLine
	CenterOfSlingshot =  $CenterOfSlingShot.position
	LeftLine.points[1] = CenterOfSlingshot
	RightLine.points[1] = CenterOfSlingshot
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.position = CenterOfSlingshot
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match SlingShotState:
		SlingState.idle:
			pass
		SlingState.pulling:
			var player = get_tree().get_nodes_in_group("Player")[0]
			if Input.is_action_pressed("Left_Mouse"):
				var distance = get_global_mouse_position()
				if distance.distance_to(CenterOfSlingshot) > 100:
					distance = (distance - CenterOfSlingshot).normalized() * 100 + $CenterOfSlingShot.position
				player.position = distance
				LeftLine.points[1] = distance
				RightLine.points[1] = distance
			else:
				var location = get_global_mouse_position()
				var distance = location.distance_to(CenterOfSlingshot)
				var velocity = CenterOfSlingshot - location
				
				player.ThrowBird()
				player = player as RigidBody2D
				player.apply_impulse(Vector2(), velocity/50 * distance)
				SlingShotState = SlingState.birdThrown
				LeftLine.points[1] = CenterOfSlingshot
				RightLine.points[1] = CenterOfSlingshot
				GameManager.CurrentGameState = GameManager.GameState.Play
				get_tree().get_nodes_in_group("Camera")[0].followingPlayer = true
		SlingState.birdThrown:
			pass
		SlingState.reset:
			var lives = get_tree().get_nodes_in_group("Player")
			if lives.size() > 0:
				Player = lives[0] as RigidBody2D
				$Tween.interpolate_property(Player,"position",Player.position, CenterOfSlingshot, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
				if (Player.global_position - CenterOfSlingshot).length() < 0.1:
					SlingShotState = SlingState.idle
				pass
	pass


func _on_TouchArea_input_event(viewport, event, shape_idx):
	if SlingShotState == SlingState.idle:
		if(event is InputEventMouseButton && event.pressed):
			SlingShotState = SlingState.pulling
	pass # Replace with function body.
