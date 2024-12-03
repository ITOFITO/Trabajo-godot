extends Node3D

@export var mesh_instance: MeshInstance3D  # Exportamos el MeshInstance3D que quieres cambiar de color
@export var new_color: Color = Color(1, 0, 0)  # Color rojo por defecto
@export var original_color: Color = Color(1, 1, 1)  # Color original (blanco por defecto)

var is_damaged: bool = false  # Variable de estado para saber si la tubería está en buen estado o dañada

func _ready():
	# Asegurarnos de que el MeshInstance3D tiene un material
	if mesh_instance.material_override == null:
		# Si no tiene material, le asignamos uno nuevo
		mesh_instance.material_override = StandardMaterial3D.new()
	
	# Establecemos el color inicial al color original
	var material = mesh_instance.material_override
	if material and material is StandardMaterial3D:
		material.albedo_color = original_color

func _process(delta):
	# Detectamos si la tecla '1' fue presionada
	if Input.is_action_just_pressed("key_7"):  # Usamos la acción 'key_1'
		
		var material = mesh_instance.material_override  # Acceder al material del MeshInstance3D

		# Verificamos si el material es un StandardMaterial3D
		if material and material is StandardMaterial3D:
			if is_damaged:
				# Si la tubería estaba dañada, la restauramos a su color original
				material.albedo_color = original_color
				print("¡La tubería está en buen estado!")
			else:
				# Si la tubería estaba en buen estado, cambiamos el color al nuevo color
				material.albedo_color = new_color
				# Generamos un mensaje de error aleatorio
				var message = "¡La tubería 7 está fallando! "
				var options = [
					"La tubería tiene mucha presión.",
					"La tubería está rota.",
					"La tubería está tapada."
				]
				var random_message = options[randi() % options.size()]  # Seleccionar un mensaje aleatorio
				print(message + random_message)
			
			# Alternamos el estado de la tubería
			is_damaged = !is_damaged
		else:
			print("Error: El material no es un StandardMaterial3D o no existe.")
