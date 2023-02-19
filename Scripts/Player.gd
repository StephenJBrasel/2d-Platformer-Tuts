extends KinematicBody2D

var speed = 500
var max_speed = 150
var friction = 0.5
var resistance = 0.7
var jump = 270
var jump_dampener = 20
var gravity_aid = jump_dampener/2
var gravity = 380
var movement_x = 0

var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var anim = $AnimationPlayer


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement_x != 0:
		velocity.x += movement_x * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		sprite.flip_h = movement_x < 0
		anim.play("run")

	if is_on_floor():
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, friction)
			anim.play("idle")
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y -= jump
	else: # if not on floor
		if velocity.y < 0:
			anim.play("jump")
			if !Input.is_action_pressed("ui_accept"):
				velocity.y = clamp(velocity.y + jump_dampener, 0, jump)
		else:
			anim.play("fall")
			velocity.y += (gravity_aid)
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, resistance)

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
