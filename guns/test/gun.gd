extends Sprite2D
class_name Gun

@onready var bullet_spawn: Node2D = $BulletSpawn
@onready var target: Node2D = $Target

@export var is_active: bool = false
const bullet = preload("res://guns/test/bullet.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		if is_active:
			var instance = bullet.instantiate()
			instance.global_position = bullet_spawn.global_position
			instance.rotation = rotation
			
			# FIXME: there has to be a better way to do this
			instance.target = target.global_position
			get_parent().add_child(instance)
			Globals.camera.shake(0.15, 20, 3)
