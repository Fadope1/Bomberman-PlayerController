extends Button

onready var animation_player: = $onHoverAnimation_options


func _on_btn_options_mouse_entered() -> void:
    animation_player.play("wiggle")


func _on_btn_options_mouse_exited() -> void:
    animation_player.seek(1.5, true)
    animation_player.stop()
