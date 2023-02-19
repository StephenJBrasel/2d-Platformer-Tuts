extends Area2D

onready var anim = $AnimationPlayer

signal Is_Active

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name:
			anim.play("active")
			yield(anim, "animation_finished")
			anim.play("idle_active")
			emit_signal("Is_Active")
		else:
			anim.play("idle")