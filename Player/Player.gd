extends Node

var isInSpeedboost = false #Boolean to track if the player is currently in a speed boost

func _ready():
	$ForwardLookingCamera.WALK_MAX_SPEED = $player.WALK_MAX_SPEED

func _physics_process(delta):
	if isInSpeedboost:
		$ForwardLookingCamera.UpdateCameraSpeedBoost($player.position, $player.velocity)
	else:
		$ForwardLookingCamera.UpdateCamera($player.position, $player.velocity)

func SwitchColorToOrange():
	pass

func SwitchColorToPurple():
	pass

func SpeedboostStart(speed):
	$player.velocity = speed
	$player.isInSpeedboost = true
	isInSpeedboost = true

func SpeedboostStop():
	$player.isInSpeedboost = false
	isInSpeedboost = false

func LaserEntered():
	$player.isSwitchColorEnabled = false

func LaserExited():
	$player.isSwitchColorEnabled = true

func _on_player_is_at_fullspeed():
	$BackgroundMusic.isAtFullspeed = true

func _on_player_is_not_at_fullspeed():
	$BackgroundMusic.isAtFullspeed = false