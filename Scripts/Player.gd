extends KinematicBody2D

var speed = 500
var max_speed = 150
var friction = 0.5
var resistance = 0.7
var jump = 270
var fall_multiplier = 2
var low_jump_multiplier = 2
var jump_start_time = 0
var jump_time_millis = 100
var jumps = 0
var max_jumps = 2
var gravity = 380
var movement_x = 0
var spring = 400
var springed = false
var was_on_floor = true

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
		if !was_on_floor:
			reset_jumps()
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, friction)
			anim.play("idle")
		if Input.is_action_just_pressed("ui_accept"):
			action_jump()
	else: # if not on floor
		if jumps < max_jumps:
			var time_since_last_jump = Time.get_ticks_msec() - jump_start_time
			print("Time: {time}".format({"time": time_since_last_jump}))
			if time_since_last_jump > jump_time_millis && Input.is_action_just_pressed("ui_accept"):
				action_jump()
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, resistance)
		if velocity.y > 0 or Input.is_action_pressed("ui_down"):
			anim.play("fall")
			velocity.y += gravity * fall_multiplier * delta
		elif velocity.y < 0:
			anim.play("jump")
			if !Input.is_action_pressed("ui_accept"):
				velocity.y += gravity * low_jump_multiplier * delta

	velocity.y += gravity * delta
	was_on_floor = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Spring_body_entered(body:Node):
	if self == body:
		springed = true
		velocity.y -= spring
		clamp_max_velocity()
		jumps += 1

func action_jump():
	jump_start_time = Time.get_ticks_msec()
	velocity.y -= jump
	clamp_max_velocity()
	jumps += 1

func clamp_max_velocity():
	if velocity.y < -spring:
		velocity.y = -spring

func reset_jumps():
	print("landed")
	jumps = 0
	springed = false
