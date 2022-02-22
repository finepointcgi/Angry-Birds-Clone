extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startingPos
var player
var followingPlayer
var clicking = false
var slingshot
# Called when the node enters the scene tree for the first time.
func _ready():
	startingPos = global_position
	player = get_tree().get_nodes_in_group("Player")[0]
	slingshot = get_tree().get_nodes_in_group("Slingshot")[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if followingPlayer:
		if is_instance_valid(player):
			if player.position.x > position.x:
				var playerpos = clamp(player.position.x, 0, 5000)
				global_position = Vector2(playerpos,startingPos.y)
		else:
			followingPlayer = false
			$Tween.interpolate_property(self,"position",position,startingPos,2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$Tween.start()
	if Input.is_action_just_pressed("Left_Mouse"):
		clicking = true
	elif Input.is_action_just_released("Left_Mouse"):
		clicking = false
	pass

func _input(event):
	if !slingshot.SlingShotState == slingshot.SlingState.pulling:
		if event is InputEventScreenDrag:
			move_local_x(event.relative.x * -1)
			move_local_y(event.relative.y * -1)
		if clicking:
			if event is InputEventMouseMotion:
				move_local_x(event.relative.x * -1)
				move_local_y(event.relative.y * -1)
