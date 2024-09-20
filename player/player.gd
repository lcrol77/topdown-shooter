extends CharacterBody2D

@export var speed = 600
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: PackedScene = preload("res://guns/test/gun.tscn")
@onready var gun_attachment_point: Node2D = $GunAttachmentPoint
@onready var loadout: Node = $Loadout

# FIXME: problem with this implementation is what to do when the player addes or drops a weapon
# i.e. when changing the size of the loadout in anyway we need to rectify this index, or we need
# a different approach
var active_weapon_idx: int = 0

func _ready() -> void:
	for weapon in loadout.get_children():
		weapon.global_position = gun_attachment_point.global_position
		weapon.visible = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var guns: Array[Node] = loadout.get_children()
	var active_weapon = get_active_weapon(guns)
	velocity = direction * speed
	if  direction != Vector2.ZERO:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	if get_global_mouse_position().x < global_position.x:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	display_gun(active_weapon)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swap_weapon"):
		var node: Gun = loadout.get_child(active_weapon_idx)
		node.is_active = false
		node.visible = false
		active_weapon_idx = active_weapon_idx + 1 if active_weapon_idx + 1 < loadout.get_child_count() else 0
		node = loadout.get_child(active_weapon_idx)
		display_gun(node)
		node.is_active = true
		

func get_active_weapon(guns: Array[Node]) -> Gun:
	if loadout.get_child_count() <= 0 or active_weapon_idx >= loadout.get_child_count():
		return null
	return guns[active_weapon_idx]
	
func display_gun(gun: Gun)->void:
	if gun == null:
		return
	gun.look_at(get_global_mouse_position())
	if get_global_mouse_position().x < global_position.x:
		gun.flip_v = true
		gun.bullet_spawn.position.y = 1
		gun.target.position.y = 1
	else:
		gun.flip_v = false
		gun.bullet_spawn.position.y = -1
		gun.target.position.y = -1
	gun.visible = true
