extends "res://UI/Main.gd"


func _ready():
	$Label.text = "You found the exit! You win!\nYour score was " + Global.score as String
