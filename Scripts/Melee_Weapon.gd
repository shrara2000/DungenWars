extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var isEquipped=true;




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction>0:
		animated_sprite.flip_h=false
	elif direction<0:
		animated_sprite.flip_h=true
	if Input.is_action_just_pressed("Attack"):
		animated_sprite.play('attack')
	if Input.is_action_just_released("Attack"):
		animated_sprite.play('idle')
	
func _on_body_entered(_body):
	if Input.is_action_pressed("Attack") or Input.is_action_just_pressed("Attack"):
		_body.queue_free()
		print("You Killed An Enemy")

