extends KinematicBody2D

## Exports ##
export var SPEED: = 500

## PRELOADING SCENES ##
const STATIC_BOMB = preload("res://Scenes/StaticBomb.tscn")
const THROW_BOMB = preload("res://Scenes/ThrowBomb.tscn")
const PHYSICS_THROW_BOMB = preload("res://Scenes/Phyics_ThrowableBomb.tscn")

## onready vars ##
onready var bomb_position = $bomb_position
onready var bomb = preload("res://Scenes/Bomb_Sprite.tscn").instance()

## Vars ##
var can_throw = true


func _ready() -> void:
    self.bomb.position = self.bomb_position.position
    self.add_child(self.bomb)
    

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


func bomb_action(bomb_node) -> void:   
    self.bomb.visible = false
    self.can_throw = false
    
    bomb_node.global_position = self.bomb_position.global_position
    bomb_node.rotation = self.rotation
    self.get_tree().get_root().add_child(bomb_node)


func _physics_process(delta: float) -> void:
    var mouse_pos: = self.get_global_mouse_position()
    self.look_at(mouse_pos) # look at mouse
    
    if self.can_throw:
        # lay a bomb
        if Input.is_action_just_pressed("lay_bomb"):
            var static_bomb = STATIC_BOMB.instance()
            bomb_action(static_bomb)

        # throw a bomb
        if Input.is_action_just_pressed("throw_bomb"):
            var throw_bomb = PHYSICS_THROW_BOMB.instance()
            throw_bomb.direction = (mouse_pos - self.global_position).normalized()
            bomb_action(throw_bomb)

    var velocity: Vector2 = self.movement().normalized() * delta * SPEED # calc velocity

    if mouse_pos.distance_to(self.get_global_position()) > 10:
        var collision: = self.move_and_collide(velocity) # move to velocity with direction


func _on_bomb_timer_timeout() -> void:
    self.can_throw = true
    self.bomb.visible = true
