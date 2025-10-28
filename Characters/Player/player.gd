extends CharacterBody2D

@export var movement_speed : float = 70

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.set("parameters/Idle/blend_position", Vector2(0, 1))

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")

	velocity = input_direction * movement_speed
	
	update_animation_parameters(input_direction)
	pick_new_anim_state()
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

func pick_new_anim_state():
	if (velocity == Vector2.ZERO):
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walk")
