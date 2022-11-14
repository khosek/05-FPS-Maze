extends "res://UI/Main.gd"


func _ready():
	$Label.text = "The robots got you - you lose!\nYour score was " + Global.score as String
