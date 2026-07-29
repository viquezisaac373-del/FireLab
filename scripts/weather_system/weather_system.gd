extends Node

@export var wind_direction: Vector2 = Vector2(1, 0)
@export var wind_strength: float = 1.0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		wind_direction = Vector2(1, 0)
		print("Viento hacia el Este, fuerza: ", wind_strength)
	elif Input.is_action_just_pressed("ui_left"):
		wind_direction = Vector2(-1, 0)
		print("Viento hacia el Oeste, fuerza: ", wind_strength)
	elif Input.is_action_just_pressed("ui_up"):
		wind_direction = Vector2(0, -1)
		print("Viento hacia el Norte, fuerza: ", wind_strength)
	elif Input.is_action_just_pressed("ui_down"):
		wind_direction = Vector2(0, 1)
		print("Viento hacia el Sur, fuerza: ", wind_strength)

	if Input.is_action_just_pressed("ui_page_up"):
		wind_strength = min(wind_strength + 0.5, 5.0)
		print("Fuerza del viento: ", wind_strength)
	elif Input.is_action_just_pressed("ui_page_down"):
		wind_strength = max(wind_strength - 0.5, 0.0)
		print("Fuerza del viento: ", wind_strength)
