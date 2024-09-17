extends CharacterBody2D

@export var speed = 600
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: Sprite2D = $Gun

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if abs(direction.x) > 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	gun.look_at(get_global_mouse_position())
	if get_global_mouse_position().x < global_position.x:
		gun.flip_v = true
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
		gun.flip_v = false
	move_and_slide()
