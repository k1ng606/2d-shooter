extends CharacterBody2D

var speed = 300
signal shootSignal

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	look_at(get_global_mouse_position())
	
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
func shoot():
	emit_signal("shootSignal")
