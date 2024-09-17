extends Sprite2D
class_name Gun

@onready var bullet_spawn: Node2D = $BulletSpawn
@export var is_active: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		print("pow")
		
	if event.is_action_released("fire"):
		print("released")
