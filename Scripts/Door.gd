extends Area2D

onready var anim = $AnimationPlayer

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name:
			var _status = get_tree().change_scene("res://Scenes/Level 1.tscn")


func _on_Lever_Is_Active():
	anim.play("opening")
	yield(anim, "animation_finished")
	anim.play("opened")
