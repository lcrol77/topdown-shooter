extends Camera2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

const smooth_lean := 10.0
const scale_lean  := 0.2

var last_physics_pos

func lean_camera_towards_mouse_(delta:float) -> void:
	var mouse_position := get_global_mouse_position()
	
	var direction_to_mouse := (mouse_position - position).normalized()
	var distance_to_mouse :=  mouse_position.distance_to(position)
	var lean := (mouse_position - position) * scale_lean
	offset = lerp(offset, lean, delta * smooth_lean)

func match_player_position_() -> void:
	position = player.position
	
func _process(delta) -> void:
	if Engine.get_frames_per_second() > 60: # This is whatever your physics fps is
		var lerp_weight = Engine.get_physics_interpolation_fraction()
		position = last_physics_pos.lerp(player.position, lerp_weight)

func _physics_process(delta) -> void:
	lean_camera_towards_mouse_(delta)
	last_physics_pos = position
	match_player_position_()
