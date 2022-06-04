extends StaticBody2D

onready var bomb_explosion = $Explosion


func ready():
	# set bomb_explosion sprite visiblity to false
	bomb_explosion.visible = false


func _on_Timer_timeout():
	# show bomb explosion and then destory self
	bomb_explosion.visible = true
	yield(get_tree().create_timer(1.0), "timeout") # für was ist der timeout string?
	queue_free()
