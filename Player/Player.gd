extends KinematicBody

onready var Camera = $Pivot/Camera

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.0015
var mouse_range = 1.2

var velocity = Vector3()

onready var RC = $Pivot/RayCast
onready var flash = $Pivot/Blaster/Flash
onready var Decal = preload("res://Player/Decal.tscn")

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	if Input.is_action_just_pressed("shoot") and !flash.visible:
		flash.shoot()
		if RC.is_colliding():
			var c = RC.get_collider()
			var decal = Decal.instance()
			RC.get_collider().add_child(decal)
			decal.global_transform.origin = RC.get_collision_point()
			decal.look_at(RC.get_collision_point() + RC.get_collision_normal(), Vector3.UP)
#			print(c.name)
			if c.is_in_group("Enemy"):
				Global.add_score(c.score)
				c.queue_free()
