extends Node

var screen_size: Vector2

onready var bomb_sprite: = $Bomb
onready var explosion_sprite: = $ExplosionAnimation2
onready var explosion_radius: = $BombRadius_Area2D


func _ready() -> void:
    # dont show explosion from beginning
    self.explosion_sprite.visible = false
    
    self.screen_size = self.get_viewport().get_visible_rect().size


func _on_Timer_timeout() -> void:
    self.explosion_sprite.visible = true # show bomb explosion sprite
    self.bomb_sprite.visible = false
    self.explosion_sprite.play("explode")
    
    if Globals.show_shockwave:
        var explosion_shockwave:= $CanvasLayer/ColorRect
        explosion_shockwave.visible = true
        explosion_shockwave.material.set_shader_param("global_position", self.global_position)
        explosion_shockwave.material.set_shader_param("screen_size", self.screen_size)
        explosion_shockwave.get_node("AnimationPlayer").play("Shockwave")

    ## check for players/ objects in range and kill them ##
    for area in self.explosion_radius.get_overlapping_areas():
        if area.is_in_group("explode"):
            area.get_parent().queue_free() # destroy the object -> remove from tree

    yield(self.get_tree().create_timer(.3), "timeout") # wait 1/2 seconds

    self.get_parent().queue_free() # destruct the parent object (delete)
