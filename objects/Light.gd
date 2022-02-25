extends Light2D

# https://www.phonoforest.com/2020/05/7-second-tutorial-smooth-flickering.html

export var FlickerFloor := 0.99;
export var FlickerCeil := 1.01;
export var FlickerDurationMin := 0.1;
export var FlickerDurationMax := 0.3;

onready var rng = RandomNumberGenerator.new();

var targetEnergy = 1.0;
var currentEnergy = 1.0;
var time = 0;
var duration = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	duration = rng.randf_range(FlickerDurationMin, FlickerDurationMax);
	
func _process(delta):
	time += delta;
	if (time < duration):
		LerpEnergy();
	else:
		time = 0;
		SetNewTarget();	
		LerpEnergy();

	
func LerpEnergy():
	self.energy = lerp(currentEnergy, targetEnergy, time / duration);

func SetNewTarget():
	duration = rng.randf_range(FlickerDurationMin, FlickerDurationMax);
	currentEnergy = targetEnergy;
	targetEnergy = rng.randf_range(FlickerFloor, FlickerCeil);










