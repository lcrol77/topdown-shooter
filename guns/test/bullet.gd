extends Area2D
class_name Bullet

@export var speed = 1000
@onready var trail_2d: Line2D = $Trail2D

var angle: Vector2
var target: Vector2

func _ready() -> void:
	angle = global_position.direction_to(target)
	trail_2d.add_point(global_position)
	
	
func _on_body_entered(body):
	print("hit", body.name)
	
func _physics_process(delta: float) -> void:
	position += angle * speed * delta 

func _on_timer_timeout() -> void:
	queue_free()
