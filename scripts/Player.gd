extends CharacterBody2D

const SPEED = 300
const JUMP_FORCE = -500
const GRAVITY = 1000
const COYOTE_TIME = 0.1  # Frames extras pra pular mesmo sem estar 100% no chão

var coyote_counter = 0

func _ready():
	# Draw dinossauro (verde, simples)
	pass

func _draw():
	draw_rect(Rect2(-16, -16, 32, 32), Color.GREEN)

func _physics_process(delta):
	# Movimento horizontal: A/D ou setas
	var input_dir = Input.get_axis("move_left", "move_right")
	velocity.x = input_dir * SPEED
	
	# Aplicar gravidade
	velocity.y += GRAVITY * delta
	
	# Coyote time: permite pular um pouco depois de sair da plataforma
	if is_on_floor():
		coyote_counter = COYOTE_TIME
	else:
		coyote_counter -= delta
	
	# Pulo: espaço ou UI accept
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_select")) and coyote_counter > 0:
		velocity.y = JUMP_FORCE
		coyote_counter = 0
	
	move_and_slide()