extends Button


onready var animation_player: = $onHoverAnimation_play


func _on_btn_play_mouse_entered() -> void:
    animation_player.play("wiggle")


func _on_btn_play_mouse_exited() -> void:
    animation_player.stop(false)
