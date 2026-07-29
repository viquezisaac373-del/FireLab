extends Node3D

enum FireState { HEALTHY, BURNING, BURNED }

@export var fire_state: FireState = FireState.HEALTHY
@export var burn_time: float = 5.0
@export var spread_radius: float = 4.0       # qué tan lejos puede propagarse el fuego
@export var spread_check_interval: float = 1.0  # cada cuánto intenta propagar

var _burn_timer: float = 0.0
var _spread_timer: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if fire_state == FireState.BURNING:
		_burn_timer += delta
		_spread_timer += delta

		if _spread_timer >= spread_check_interval:
			_spread_timer = 0.0
			_try_spread_fire()

		if _burn_timer >= burn_time:
			_set_burned()

func ignite() -> void:
	if fire_state == FireState.HEALTHY:
		fire_state = FireState.BURNING
		_burn_timer = 0.0
		print("El árbol se está incendiando 🔥")
		_update_visual()

func extinguish() -> void:
	if fire_state == FireState.BURNING:
		fire_state = FireState.HEALTHY
		_burn_timer = 0.0
		print("El fuego fue apagado 💧")
		_update_visual()

func _set_burned() -> void:
	fire_state = FireState.BURNED
	print("El árbol se consumió por completo")
	_update_visual()

func _try_spread_fire() -> void:
	var trees := get_tree().get_nodes_in_group("trees")
	for other in trees:
		if other == self:
			continue
		if other.fire_state != FireState.HEALTHY:
			continue

		var to_other: Vector3 = other.global_position - global_position
		var distance: float = to_other.length()

		if distance > spread_radius:
			continue

		# Influencia del viento: si el árbol vecino está en la dirección del viento, más probabilidad
		var wind_dir3 := Vector3(WeatherSystem.wind_direction.x, 0, WeatherSystem.wind_direction.y).normalized()
		var direction_to_other := to_other.normalized()
		var wind_alignment: float = wind_dir3.dot(direction_to_other)  # -1 a 1

		var base_chance: float = 1.0 - (distance / spread_radius)  # más cerca = más probable
		var wind_bonus: float = max(wind_alignment, 0.0) * WeatherSystem.wind_strength
		var final_chance: float = clamp(base_chance + wind_bonus * 0.3, 0.0, 1.0)

		if randf() < final_chance * 0.3:  # multiplicador general para no propagar demasiado rápido
			other.ignite()

func _update_visual() -> void:
	var foliage: MeshInstance3D = get_node_or_null("Foliage")
	if foliage == null:
		return
	var mat := StandardMaterial3D.new()
	match fire_state:
		FireState.HEALTHY:
			mat.albedo_color = Color(0.2, 0.6, 0.2)
		FireState.BURNING:
			mat.albedo_color = Color(0.9, 0.3, 0.0)
		FireState.BURNED:
			mat.albedo_color = Color(0.15, 0.1, 0.1)
	foliage.material_override = mat

func _on_click_area_input_event(_camera: Node, event: InputEvent, _pos: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and fire_state == FireState.HEALTHY:
			ignite()
		elif event.button_index == MOUSE_BUTTON_RIGHT and fire_state == FireState.BURNING:
			extinguish()
