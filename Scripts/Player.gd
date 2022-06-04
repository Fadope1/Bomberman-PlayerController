extends KinematicBody2D

## GLOBALS ##
export var SPEED: = 500

## PRELOADING SCENES ##
const STATIC_BOMB = preload("res://Scenes/StaticBomb.tscn")


func movement() -> Vector2:
	var direction: = Vector2.ZERO
	
	# check for keyboard input and add to direction
	if Input.is_action_pressed("forward"):
		direction += self.transform.x
	if Input.is_action_pressed("backward"):
		direction -= self.transform.x
	if Input.is_action_pressed("right"):
		direction += self.transform.y
	if Input.is_action_pressed("left"):
		direction -= self.transform.y
	
	return direction


func _physics_process(delta):
	look_at(get_global_mouse_position()) # look at mouse
	
	# spawn new lay_bomb
	if Input.is_action_just_pressed("lay_bomb"):
		var static_bomb = STATIC_BOMB.instance()
		static_bomb.position = self.global_position
		get_tree().get_root().add_child(static_bomb)
	
	var velocity = movement().normalized() * delta * SPEED # calc velocity
	
	var collision: = move_and_collide(velocity) # move to velocity with direction
	









