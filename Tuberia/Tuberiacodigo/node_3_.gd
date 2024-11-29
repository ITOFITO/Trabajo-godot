extends Node3D

@export var mesh_instance: MeshInstance3D  # Exportamos el MeshInstance3D que quieres cambiar de color
@export var new_color: Color = Color(1, 0, 0)  # Color rojo por defecto

func _ready():
	# Asegurarnos de que el MeshInstance3D tiene un material
	if mesh_instance.material_override == null:
		# Si no tiene material, le asignamos uno nuevo
		mesh_instance.material_override = StandardMaterial3D.new()

func _process(delta):
	# Detectamos si la tecla '1' fue presionada
	if Input.is_action_just_pressed("key_3"):  # Usamos la acción 'key_1'
		
		# Cambiar el color del MeshInstance3D
		var material = mesh_instance.material_override  # Acceder al material del MeshInstance3D
		
		# Verificamos si el material es un StandardMaterial3D
		if material and material is StandardMaterial3D:
			material.albedo_color = new_color  # Cambiar el color del material
		else:
			print("Error: El material no es un StandardMaterial3D o no existe.")
		
		# Mostrar el mensaje de error en la consola
		var message = "¡La tubería 3 está fallando! "  # Mensaje base
		var options = [
			"La tubería tiene mucha presión.",
			"La tubería está rota.",
			"La tubería está tapada."
		]
		var random_message = options[randi() % options.size()]  # Seleccionar un mensaje aleatorio
		print(message + random_message)  # Imprimir el mensaje completo en la consola
