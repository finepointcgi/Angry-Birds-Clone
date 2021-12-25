extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 150.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	contact_monitor = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pig_body_entered(body):
	if is_instance_valid(body):
		if body is RigidBody2D:
			if body.is_in_group("Player"):
				queue_free()
			else:
				var damage = body.linear_velocity.length() * 10
				health -= damage
				if health <= 0:
					queue_free()
		
	pass # Replace with function body.