extends Spatial


func _ready():
	pass

func shoot():
	show()
	$Timer.start()

func _on_Timer_timeout():
	hide()
