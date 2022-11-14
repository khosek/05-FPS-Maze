extends KinematicBody

var score = 5
var Player = null

func _ready():
	pass

func _physics_process(_delta):
	if Player == null:
		Player = get_node_or_null("/root/Game/Player")
	if Player != null:
		look_at(Player.global_transform.origin, Vector3.UP)
		if $RayCast.is_colliding():
			var c = $RayCast.get_collider()
			if c.is_in_group("Player"):
				var _v = move_and_slide(Vector3(0, 0, -1).rotated(Vector3.UP, rotation.y))

func _on_Sound_Area_body_entered(body):
	if body.name == "Player":
		var sound = get_node_or_null("/root/Game/Robot")
		if sound != null and !sound.playing:
			sound.playing = true

func _on_Hurtbox_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://UI/Lose.tscn")
