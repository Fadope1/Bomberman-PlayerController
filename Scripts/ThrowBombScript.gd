extends KinematicBody2D

export var SPEED: = 500

onready var bomb_explosion = $Explosion
onready var bomb_radius = $BombRadius_Area2D
var direction: = Vector2.ZERO # given by player

var move: = true


func ready() -> void:
    self.bomb_explosion.visible = false
    

func _physics_process(delta: float) -> void:
    if self.move:
        var collision: = self.move_and_collide(self.direction*delta*SPEED)
    
        if collision:
            print("[ThrowBomb] Collision Detected")


func _on_Timer_timeout() -> void:
    self.move = false # stop moving
    
    self.explode()
    
    
func explode() -> void:
    # show bomb explosion and then destory self
    self.bomb_explosion.visible = true
    
    ## check for players in range here and kill them ##
    for area in self.bomb_radius.get_overlapping_areas():
        area.get_parent().queue_free()
    
    yield(self.get_tree().create_timer(.5), "timeout")
    
    self.queue_free() # self destruct from tree
