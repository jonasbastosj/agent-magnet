extends Node2D

const PLATFORM_WIDTH = 100
const PLATFORM_HEIGHT = 16
const PLATFORM_SPACING = 80
const PLATFORMS_COUNT = 15
const SCREEN_HEIGHT = 720

var player: CharacterBody2D
var camera_target = 0

func _ready():
	player = get_node("Player")
	var collision = player.get_node("CollisionShape2D")
	var shape = RectangleShape2D.new()
	shape.size = Vector2(32, 32)
	collision.shape = shape
	
	# Cria plataformas
	for i in range(PLATFORMS_COUNT):
		var platform = StaticBody2D.new()
		
		# Collision
		var collision_shape = CollisionShape2D.new()
		var platform_shape = RectangleShape2D.new()
		platform_shape.size = Vector2(PLATFORM_WIDTH, PLATFORM_HEIGHT)
		collision_shape.shape = platform_shape
		platform.add_child(collision_shape)
		
		# Visual
		var visual = ColorRect.new()
		visual.size = Vector2(PLATFORM_WIDTH, PLATFORM_HEIGHT)
		visual.color = Color.GREEN
		visual.offset = Vector2(-PLATFORM_WIDTH/2, -PLATFORM_HEIGHT/2)
		platform.add_child(visual)
		
		# Posição
		var x = 200 if i % 2 == 0 else 600
		var y = SCREEN_HEIGHT - 100 - (i * PLATFORM_SPACING)
		platform.position = Vector2(x, y)
		
		add_child(platform)
	
	# Configura câmera
	var camera = get_node("Camera2D")
	camera.set_anchors_preset(Control.PRESET_CENTER)

func _process(delta):
	if player:
		var target_y = player.position.y - SCREEN_HEIGHT / 3
		camera_target = lerp(camera_target, target_y, 0.1)
		get_node("Camera2D").global_position.y = camera_target
		
		var height_percent = max(0, (SCREEN_HEIGHT - 100 - player.position.y) / 1200.0)
		print("Altura: %.0f%%" % (height_percent * 100))
		
		if player.position.y < 50:
			print("VITÓRIA! Você subiu a torre!")
			get_tree().reload_current_scene()
		
		if player.position.y > SCREEN_HEIGHT + 200:
			print("Caiu! Game Over")
			get_tree().reload_current_scene()
