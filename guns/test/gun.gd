extends Sprite2D
class_name Gun

@onready var bullet_spawn: Node2D = $BulletSpawn
@export var is_active: bool = false
const bullet = preload("res://guns/test/bullet.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		if is_active:
			var instance = bullet.instantiate()
			instance.global_position = bullet_spawn.global_position
			instance.rotation = rotation
			# FIXME: when using this method of setting the target there is a bug 
			# that causes the bullet to shoot into and behind the player if the mouse 
			# is clicked behind the bullet spawn point
			instance.target = get_global_mouse_position()
			get_parent().add_child(instance)
