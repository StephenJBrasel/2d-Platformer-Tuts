extends Area2D

onready var anim = $AnimationPlayer

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name:
			anim.play("destroyed")
			yield(anim, "animation_finished")
			queue_free()
		else:
			anim.play("idle")
