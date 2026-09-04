extends Node2D

const PLATFORM_WIDTH = 100
const PLATFORM_HEIGHT = 16
const PLATFORM_SPACING = 80  # Espaço entre plataformas
const PLATFORMS_COUNT = 15
const SCREEN_HEIGHT = 720

@onready var player = null
var platforms = []
var camera_target = 0

func _ready():
	# Cria o player (dinossauro)
	player = CharacterBody2D.new()
	player.position = Vector2(400, SCREEN_HEIGHT - 100)
	
	# Collision do player
	var player_collision = CollisionShape2D.new()
	var player_shape = RectangleShape2D.new()
	player_shape.size = Vector2(32, 32)
	player_collision.shape = player_shape
	player.add_child(player_collision)
	
	player.add_script(load("res://scripts/Player.gd"))
	add_child(player)
	
	# Cria plataformas formando uma torre
	for i in range(PLATFORMS_COUNT):
		var platform = StaticBody2D.new()
		
		# Collision da plataforma
		var collision = CollisionShape2D.new()
		var platform_shape = RectangleShape2D.new()
		platform_shape.size = Vector2(PLATFORM_WIDTH, PLATFORM_HEIGHT)
		collision.shape = platform_shape
		platform.add_child(collision)
		
		# Visual (ColorRect verde)
		var visual = ColorRect.new()
		visual.size = Vector2(PLATFORM_WIDTH, PLATFORM_HEIGHT)
		visual.color = Color.GREEN
		visual.offset = Vector2(-PLATFORM_WIDTH/2, -PLATFORM_HEIGHT/2)
		platform.add_child(visual)
		
		# Posiciona: alterna esquerda/direita e sobe
		var x = 200 if i % 2 == 0 else 600
		var y = SCREEN_HEIGHT - 100 - (i * PLATFORM_SPACING)
		platform.position = Vector2(x, y)
		
		add_child(platform)
		platforms.append(platform)
	
	# Camera segue o player
	var camera = Camera2D.new()
	camera.set_anchors_preset(Control.PRESET_CENTER)
	add_child(camera)

func _process(delta):
	# Camera segue player pra cima
	if player:
		var target_y = player.position.y - SCREEN_HEIGHT / 3
		camera_target = lerp(camera_target, target_y, 0.1)
		get_node("Camera2D").global_position.y = camera_target
		
		# Mostrar altura (quanto subiu)
		var height_percent = max(0, (SCREEN_HEIGHT - 100 - player.position.y) / 1200.0)
		print("Altura: %.0f%%" % (height_percent * 100))
		
		# Vitória: chegou no topo
		if player.position.y < 50:
			print("VITÓRIA! Você subiu a torre!")
			get_tree().reload_current_scene()
		
		# Derrota: caiu muito pra baixo
		if player.position.y > SCREEN_HEIGHT + 200:
			print("Caiu! Game Over")
			get_tree().reload_current_scene()
