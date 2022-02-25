extends KinematicBody2D


export (int) var Speed = 30;
export (float) var TurnSpeed = 0.1;
export (float) var StopSpeed = 0.1;

onready var camera = $Camera2D;
onready var animation = $AnimationPlayer;
onready var root = get_tree().get_root();

var velocity = Vector2();
var targetRot = rotation;
var time = 0;
	
func _ready():
	camera.make_current();
	
func get_input():
	velocity = Vector2();
	# Stupid hack to get this working because viewports are aparently busted in 2d
	# woo https://github.com/godotengine/godot/issues/30215#issuecomment-512046558
	var mousePos = root.get_mouse_position() - get_viewport().canvas_transform.origin;
	targetRot = mousePos.angle_to_point(position);
	
	if Input.is_action_pressed("back"):
		velocity = Vector2(-Speed, 0).rotated(rotation);
		
	if Input.is_action_pressed("forward"):
		velocity = Vector2(Speed, 0).rotated(rotation);

func _physics_process(delta):
	get_input();
	rotation = lerp_angle(rotation, targetRot, TurnSpeed);
	velocity = move_and_slide(velocity);
	
	if (velocity.length() > StopSpeed):
		animation.play("Walk");
	else:
		animation.play("Idle");
