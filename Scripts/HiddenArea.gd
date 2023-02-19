extends Area2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

var playerPresent = false

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name:
			playerPresent = true
			break
	if playerPresent:
		if sprite.visible:
			anim.play("revealing")
		else:
			anim.play("revealed")
	else:
		anim.play("hidden")
	playerPresent = false
