extends StaticBody2D

onready var bomb_explosion = $Explosion
onready var bomb_radius = $BombRadius_Area2D


func ready() -> void:
    # set bomb_explosion sprite visiblity to false
    bomb_explosion.visible = false


func _on_Timer_timeout() -> void:
    # show bomb explosion and then destory self
    bomb_explosion.visible = true

    ## check for players in range here and kill them ##
    for area in bomb_radius.get_overlapping_areas():
        if area.is_in_group("explode"):
            area.get_parent().queue_free()

    yield(self.get_tree().create_timer(.5), "timeout")

    self.queue_free() # self destruct from tree
