extends Area2D
@onready var ray_cast_right = $RayCast2DRight
@onready var ray_cast_left = $RayCast2DLeft
@onready var animated_sprite = $AnimatedSprite2D
var current_direction;
var tracked_ray;
var isEquipped=false;
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_direction=1;
	animated_sprite.z_index=3;
	if (Input.is_action_just_pressed("Attack") or Input.is_action_pressed("Attack")):
		animated_sprite.play("Attack")
	elif(Input.is_action_just_released("Attack")):
		animated_sprite.play("Idle")
	var direction = Input.get_axis("move_left", "move_right")
	if direction>0:
		animated_sprite.flip_h=false
		current_direction=1
	elif direction<0:
		animated_sprite.flip_h=true
		current_direction=-1
	if current_direction==1:
		tracked_ray=ray_cast_right;
		
	elif current_direction==-1 :
		tracked_ray=ray_cast_left
		
	var collider=tracked_ray.get_collider();
	if (collider and (Input.is_action_pressed("Attack") or Input.is_action_just_pressed("Attack")) and collider is CharacterBody2D):
			collider.queue_free();
			print("Enemy Killed")
			
			
	
		
	
