extends Area2D

onready var anim = $AnimationPlayer

var playerPresent = false

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name:
			playerPresent = true
			break
	if playerPresent:
		playerPresent = false
		print("Player sprung spring!")
		anim.play("active")
		yield(anim, "animation_finished")
	else:
		anim.play("idle")
