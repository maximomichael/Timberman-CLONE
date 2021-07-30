extends Node

signal ClickPlayer(posPlayer)
signal LossGame()
signal upHUD()
signal WinGame()

var level = 0
var score = 0
var time = 0.0
var timeOut = 30.0
var pauseTime = false
func _process(delta):
	if !pauseTime:
		if time <= timeOut:	
			time += delta
			timerCount()
		else:
			playerDied()

func NewClick(posPlayer):
	emit_signal("ClickPlayer", posPlayer)

func playerWin():
	pauseTime = true
	GameControl.level += 1
	emit_signal("WinGame")


func playerDied():	
	pauseTime = true
	GameControl.level = 0
	emit_signal("LossGame")

func newPoint():
	score += 1
	emit_signal("upHUD")

func timerCount():
	emit_signal("upHUD")

