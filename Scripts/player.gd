extends CharacterBody2D


var SPEED = 130.0
var JUMP_VELOCITY = -300
@onready var animated_sprite = $AnimatedSprite2D
@onready var ranged_weapon = $Ranged_Weapon
@onready var melee_weapon = $"Melee Weapon"

var second_jump=true;
var is_sprinting =false;
var is_crouching =false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle Weapon Change
	ranged_weapon.visible=ranged_weapon.isEquipped
	melee_weapon.visible=melee_weapon.isEquipped
	if Input.is_action_just_pressed("Switch_Weapons"):
		ranged_weapon.isEquipped=!ranged_weapon.isEquipped
		melee_weapon.isEquipped=!melee_weapon.isEquipped
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		second_jump=true
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and second_jump:
		second_jump=false
		velocity.y = JUMP_VELOCITY*1.1
	# Handle Sprint
	if (Input.is_action_just_pressed("sprint") or Input.is_action_pressed("sprint"))  :
		SPEED=200;
		is_sprinting=true
	if Input.is_action_just_released("sprint") :
		SPEED=130;
		is_sprinting=false
	#Handle Crouch
	if Input.is_action_just_pressed("crouch") or Input.is_action_pressed("crouch"):
		SPEED=100;
		JUMP_VELOCITY=-250
		is_crouching=true;
		second_jump=false;
	if Input.is_action_just_released("crouch") :
		SPEED=130;
		JUMP_VELOCITY=-300
		is_crouching=false;
		
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# Animation Handling 
	var direction = Input.get_axis("move_left", "move_right")
	if direction>0:
		animated_sprite.flip_h=false
	elif direction<0:
		animated_sprite.flip_h=true
	# Movement Handling
	if 	is_on_floor():
		if direction==0:
			animated_sprite.play("idle")
		if direction==0 and is_crouching:
			animated_sprite.play("crouch")
		elif direction!=0 and not is_sprinting  :
			animated_sprite.play("run")
		elif direction!=0 and is_sprinting:
			animated_sprite.play("sprint")
		if  direction!=0 and is_crouching:
			animated_sprite.play("crouch")
		
	else :
		animated_sprite.play("jump")
	if direction:
		velocity.x = direction * SPEED;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
