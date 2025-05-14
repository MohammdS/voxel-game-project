extends RigidBody3D


## set the amount of verticacle force 
@export var thrust: float = 1000.0

##set the amount of torque thrust
@export var torque_thrust: float = 100.0

@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound
@onready var rocket_thrust_audio: AudioStreamPlayer3D = $RocketThrustAudio
@onready var level_passed_audio: AudioStreamPlayer = $LevelPassedAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles

var is_transistion: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_pressed("UP"):
		apply_central_force(basis.y * delta * thrust)
		booster_particles.emitting= true
		if rocket_thrust_audio.playing == false:
			rocket_thrust_audio.play()
	else:
		rocket_thrust_audio.stop()
		booster_particles.emitting = false
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0,0,-torque_thrust * delta))

	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0,0,torque_thrust * delta))


func _on_body_entered(body: Node) -> void:
	if is_transistion == false:
		if "Goal" in body.get_groups():
			level_complete(body.file_path)
			
		if "Hazard" in body.get_groups():
			crash()
			
func crash() -> void:
	print("Crashed!!!")
	explosion_sound.play()
	set_process(false)
	is_transistion = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)

	
func level_complete(next_level_file: String) -> void:
	print("Level Passed!")
	level_passed_audio.play()
	set_process(false)
	is_transistion = true
	var tween = create_tween()
	tween.tween_interval(2)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
