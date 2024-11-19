extends Node3D

@export var tube: MeshInstance3D
@export var new_color: Color = Color(1, 0, 0)  # Color rojo por defecto

func _ready():
	# Si no se ha asignado el tubo, lo buscamos automáticamente
	if not tube:
		tube = $MeshInstance3D  # Buscar el MeshInstance3D dentro de la escena
		
	# Asegúrate de que el tubo tiene un material por defecto.
	if tube.material_override == null:
		# Si no tiene material, creamos un nuevo material
		tube.material_override = StandardMaterial3D.new()

func _process(delta):
	# Detectar si se presiona la tecla '1' usando la acción definida en el Input Map
	if Input.is_action_just_pressed("key_2"):  # Usamos la acción 'key_1'
		print("Tuberia 2 esta fallando")  # Para depuración
		var material = tube.material_override  # Acceder al material del MeshInstance3D
		
		# Verificamos si el material es un StandardMaterial3D
		if material and material is StandardMaterial3D:
			material.albedo_color = new_color  # Cambiar el color del material
		else:
			print("Error: El material no es un StandardMaterial3D o no existe.")
