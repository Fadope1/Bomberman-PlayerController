extends KinematicBody2D

export var SPEED: = 500

var move: = true
var direction: = Vector2.ZERO

onready var bomb = $Bomb


func _process(delta: float) -> void:
    # check if explosion sprite is visible -> stop moving
    if self.bomb.explosion_sprite.visible:
        self.move = false


func _physics_process(delta: float) -> void:
    # move until collision happened
    if self.move:
        var collision: = self.move_and_collide(self.direction*delta*SPEED)

        if collision: # stop moving on inpact
            self.move = false
            
            
