extends Node3D

@export var mesh_instance: MeshInstance3D  # Exportamos el MeshInstance3D que quieres cambiar de color
@export var new_color: Color = Color(1, 0, 0)  # Color rojo por defecto
@export var original_color: Color = Color(1, 1, 1)  # Color original (blanco por defecto)

var is_damaged: bool = false  # Variable de estado para saber si la tubería está en buen estado o dañada
var is_blinking: bool = false  # Controla si el parpadeo está activado o desactivado
var blink_timer: float = 0.0  # Temporizador para el parpadeo
var blink_interval: float = 0.5  # Intervalo de tiempo entre parpadeos

var failure_messages: Array = [
	"¡La tubería tiene mucha presión!",
	"¡La tubería está rota!",
	"¡La tubería está tapada!",
	"¡La tubería no tiene presión!",
	"¡Hay una fuga en la tubería!"
]

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
	if Input.is_action_just_pressed("key_6"):  # Usamos la acción 'key_1'
		is_damaged = !is_damaged  # Alternamos el estado de la tubería

		# Si la tubería está dañada, activamos o desactivamos el parpadeo
		if is_damaged:
			is_blinking = true  # Iniciar el parpadeo
			print("¡La tubería 6 está fallando!")
			
			# Mostrar mensaje de fallo aleatorio
			var random_message = failure_messages[randi() % failure_messages.size()]  # Seleccionar un mensaje aleatorio
			print(random_message)
		else:
			is_blinking = false  # Detener el parpadeo
			var material = mesh_instance.material_override
			if material and material is StandardMaterial3D:
				material.albedo_color = original_color  # Restauramos el color original
			print("¡La tubería 6 está en buen estado!")

		# Reiniciamos el temporizador cuando se presiona la tecla
		blink_timer = 0.0

	# Si el parpadeo está activado, alternamos el color
	if is_blinking:
		blink_timer += delta
		if blink_timer >= blink_interval:
			# Alternamos el color entre el nuevo color y el original
			var material = mesh_instance.material_override
			if material and material is StandardMaterial3D:
				if material.albedo_color == new_color:
					material.albedo_color = original_color
				else:
					material.albedo_color = new_color

			# Reiniciar el temporizador para el siguiente parpadeo
			blink_timer = 0.0
