extends Node

func _ready():
	#$UI/GameStartTimer/AnimationPlayer.play("LevelStartTimer")
	#get_node("Player/player/AnimationPlayer").play("CharacterGameStartAnimation")
	pass

func _on_player_switched_color_to_orange():
	$Level.SwitchColorToOrange()
	$UI.SwitchColorToOrange()

func _on_player_switched_color_to_purple():
	$Level.SwitchColorToPurple()
	$UI.SwitchColorToPurple()

func _on_Speedboost_speedboost_start(speed):
	$Player.SpeedboostStart(speed)
	$UI.SpeedboostStart()

func _on_Speedboost_speedboost_stop():
	$Player.SpeedboostStop()
	$UI.SpeedboostStop()

func _on_player_is_at_fullspeed():
	$UI.RunFullspeedMode()
	$Player.PlayerIsAtFullspeed()


func _on_player_is_not_at_fullspeed():
	$UI.StopFullspeedMode()
	$Player.PlayerIsNotAtFullspeed()


func _on_Collectible_collected():
	$UI.CollectibleCollected()

func _on_FinishArea_finish_line_passed():
	$Player.FinishLinePassed()
	#get_tree().paused = true
	$UI.FinishLinePassed()

func _on_BackgroundMusic_drum_beat():
	$UI.MusicBeat()

func _on_Lasers_laser_entered():
	$Player.LaserEntered()

func _on_Lasers_laser_exited():
	$Player.LaserExited()


func _on_player_QuickReload():
	$Player/ForwardLookingCamera.position = $Player/player.playerStartPosiotion
	$Player/ForwardLookingCamera.lastOffset = $Player/player.playerStartPosiotion
	$Player/ForwardLookingCamera.isInSpeedBoost = false
	$Player/ForwardLookingCamera/HeadCamCollider.isZoomedOut = false
	$UI.Reload()
	$Level.Reload()
