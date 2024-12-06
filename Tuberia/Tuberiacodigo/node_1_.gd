extends Node3D

@export var mesh_instance: MeshInstance3D  # Exportamos el MeshInstance3D que quieres cambiar de color
@export var new_color: Color = Color(1, 0, 0)  # Color rojo por defecto
@export var original_color: Color = Color(1, 1, 1)  # Color original (blanco por defecto)

var is_damaged: bool = false  # Variable de estado para saber si la tubería está en buen estado o dañada
var is_blinking: bool = false  # Controla si el parpadeo está activado o desactivado
var blink_timer: float = 0.0  # Temporizador para el parpadeo
var blink_interval: float = 0.5  # Intervalo de tiempo entre parpadeos
var failure_delay_timer: float = 0.0  # Temporizador para el retraso antes de que la tubería falle
var failure_delay: float = 10.0  # 10 segundos de retraso antes de fallar
var has_warning_shown: bool = false  # Controla si el mensaje de advertencia ha sido mostrado

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

	# Probabilidad de que la tubería empiece a fallar sola (40%)
	if randi() % 100 < 40:  # randi() genera un número aleatorio entre 0 y un valor muy grande, usamos el módulo 100 para tener un rango entre 0 y 99
		print("la tubería 1 tiene grandes probabilidades de fallar...")
		failure_delay_timer = failure_delay  # Iniciamos el temporizador de 10 segundos
		has_warning_shown = true  # Indicamos que el mensaje de advertencia ya fue mostrado

func _process(delta):
	# Si estamos esperando el retraso antes de que la tubería falle
	if failure_delay_timer > 0.0:
		failure_delay_timer -= delta  # Reducimos el temporizador
		if failure_delay_timer <= 0.0:
			# El retraso ha terminado, la tubería empieza a fallar
			is_damaged = true
			is_blinking = true  # Iniciar el parpadeo automáticamente
			print("¡La tubería 1 está fallando ahora!")

			# Mostrar mensaje de fallo aleatorio
			var random_message = failure_messages[randi() % failure_messages.size()]  # Seleccionar un mensaje aleatorio
			print(random_message)

	# Detectamos si la tecla '1' fue presionada
	if Input.is_action_just_pressed("key_1"):  # Usamos la acción 'key_1'
		is_damaged = !is_damaged  # Alternamos el estado de la tubería

		# Si la tubería está dañada, activamos o desactivamos el parpadeo
		if is_damaged:
			is_blinking = true  # Iniciar el parpadeo
			print("¡La tubería 1 está fallando!")
			
			# Mostrar mensaje de fallo aleatorio
			var random_message = failure_messages[randi() % failure_messages.size()]  # Seleccionar un mensaje aleatorio
			print(random_message)
		else:
			is_blinking = false  # Detener el parpadeo
			var material = mesh_instance.material_override
			if material and material is StandardMaterial3D:
				material.albedo_color = original_color  # Restauramos el color original
			print("¡La tubería está 1 en buen estado!")

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
