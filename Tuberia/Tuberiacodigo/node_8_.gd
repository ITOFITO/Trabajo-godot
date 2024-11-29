extends Node3D

@export var tube: MeshInstance3D
@export var new_color: Color = Color(1, 0, 0)  # Color rojo por defecto
@export var label: Label  # Exportamos el Label que mostrará el texto

var timer: Timer  # Variable para el temporizador

func _ready():
	# Si no se ha asignado el tubo, lo buscamos automáticamente
	if not tube:
		tube = $MeshInstance3D  # Buscar el MeshInstance3D dentro de la escena
		
	# Asegúrate de que el tubo tiene un material por defecto.
	if tube.material_override == null:
		# Si no tiene material, creamos un nuevo material
		tube.material_override = StandardMaterial3D.new()
	
	# Si no se ha asignado el Label, lo buscamos automáticamente
	if not label:
		label = $Label  # Buscar el Label dentro de la escena

	# Asegurarse de que el Label no esté visible al inicio
	label.visible = false

	# Crear un temporizador
	timer = Timer.new()
	add_child(timer)  # Añadir el temporizador a la escena
	timer.one_shot = true  # El temporizador solo se activa una vez
	timer.wait_time = 3  # Configurar para 3 segundos

func _process(delta):
	# Detectar si se presiona la tecla '4' usando la acción definida en el Input Map
	if Input.is_action_just_pressed("key_8"):  # Usamos la acción 'key_4'
		print("Tubería 8 está fallando")  # Para depuración
		var material = tube.material_override  # Acceder al material del MeshInstance3D
		
		# Verificamos si el material es un StandardMaterial3D
		if material and material is StandardMaterial3D:
			material.albedo_color = new_color  # Cambiar el color del material
		else:
			print("Error: El material no es un StandardMaterial3D o no existe.")
		
		# Mostrar un texto aleatorio en el Label
		var messages = [
			"Tubería con mucha presión",
			"Tubería agrietada",
			"Tubería tapada"
		]
		var random_message = messages[randi() % messages.size()]  # Selecciona un mensaje aleatorio
		label.text = random_message
		label.visible = true  # Hacer visible el Label

		# Iniciar el temporizador y esperar a que termine
		await timer.timeout  # Esperar a que el temporizador se termine

		# Ocultar el texto después de 3 segundos
		label.visible = false
