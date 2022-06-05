extends Node

onready var explosion_sprite: = $Explosion
onready var explosion_radius: = $BombRadius_Area2D


func _ready() -> void:
    # dont show explosion from beginning
    self.explosion_sprite.visible = false


func _on_Timer_timeout() -> void:
    self.explosion_sprite.visible = true # show bomb explosion sprite

    ## check for players/ objects in range and kill them ##
    for area in self.explosion_radius.get_overlapping_areas():
        if area.is_in_group("explode"):
            area.get_parent().queue_free() # destroy the object -> remove from tree

    yield(self.get_tree().create_timer(.3), "timeout") # wait 1/2 seconds

    self.get_parent().queue_free() # destruct the parent object (delete)
