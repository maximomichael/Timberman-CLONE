extends CanvasLayer


func _ready():
	GameControl.connect("upHUD", self, "updateHUD")
	updateHUD()


func updateHUD():
	$Score.text = str(GameControl.score)
	var value = (188 / GameControl.timeOut) * GameControl.time
	$Backgroud/Loading.region_rect = Rect2(0, 0, value, 23)
