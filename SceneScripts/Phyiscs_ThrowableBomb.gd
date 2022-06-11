extends RigidBody2D

export var SPEED: = 200

var direction: = Vector2.ZERO

onready var bomb = $Bomb


func _ready() -> void:
    self.apply_central_impulse(direction*SPEED)
    self.add_torque(rand_range(-5, 5)*1_000)
    self.bounce = .4
    

func _process(delta: float) -> void:
    # check if explosion sprite is visible -> stop moving
    if self.bomb.explosion_sprite.visible:
        self.sleeping = true
    

func _physics_process(delta: float) -> void:
    pass
