extends KinematicBody2D

## GLOBALS ##
export var SPEED: = 500

## PRELOADING SCENES ##
const STATIC_BOMB = preload("res://Scenes/StaticBomb.tscn")
const THROW_BOMB = preload("res://Scenes/ThrowBomb.tscn")


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


func _physics_process(delta: float) -> void:
    var mouse_pos: = self.get_global_mouse_position()
    self.look_at(mouse_pos) # look at mouse
    
    # lay a bomb
    if Input.is_action_just_pressed("lay_bomb"):
        var static_bomb = STATIC_BOMB.instance()
        static_bomb.position = self.global_position
        self.get_tree().get_root().add_child(static_bomb)
    
    # throw a bomb
    if Input.is_action_just_pressed("throw_bomb"):
        var throw_bomb = THROW_BOMB.instance()
        throw_bomb.global_position = self.global_position
        throw_bomb.direction = (mouse_pos - self.global_position).normalized()
        self.get_tree().get_root().add_child(throw_bomb)
    
    var velocity: Vector2 = self.movement().normalized() * delta * SPEED # calc velocity
    
    var collision: = self.move_and_collide(velocity) # move to velocity with direction
    
    if collision:
        print("[Player] Collision Detected")








