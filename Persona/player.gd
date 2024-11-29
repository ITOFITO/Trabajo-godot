extends Node3D

@export var move_speed : float = 10.0  # Velocidad de movimiento
@export var sensitivity : float = 0.2  # Sensibilidad del ratón

var yaw : float = 0.0    # Rotación horizontal
var pitch : float = 0.0  # Rotación vertical

func _ready():
	# Configuramos el modo de ratón al comenzar
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		# Rotación de la cámara con el ratón
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		pitch = clamp(pitch, -90.0, 90.0)  # Limitar rotación vertical

		# Aplicar rotación
		rotation_degrees = Vector3(pitch, yaw, 0)

func _process(delta):
	var move_dir = Vector3.ZERO
	# Movimiento con las teclas
	if Input.is_action_pressed("up"):
		move_dir.z -= 1
	if Input.is_action_pressed("down"):
		move_dir.z += 1
	if Input.is_action_pressed("left"):
		move_dir.x -= 1
	if Input.is_action_pressed("right"):
		move_dir.x += 1

	# Normalizamos el vector de movimiento
	move_dir = move_dir.normalized()

	# Obtener la dirección en el espacio mundial usando el "transform" de la cámara
	var direction = (transform.basis * move_dir).normalized()

	# Aplicar movimiento
	global_transform.origin += direction * move_speed * delta
