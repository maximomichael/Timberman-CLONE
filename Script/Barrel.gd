extends Node2D

enum typeDir {
	barrelNull = -1,
	Friend = 0,
	EnemyLeft = 1,
	EnemyRight = 2
}

export(typeDir)  var typeBarrel = 0
var newPosition = 0
var call = false
var positionHammer = 600

func _process(delta):
	if call == true:
		$Tween.interpolate_method(self, "destroyObject", 0, 1, .6, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
		call = false
	
func destroy(positionPlayer):
	call = true 
	positionHammer *= positionPlayer
	yield(get_tree().create_timer(.4), "timeout")
	self.free()

func modeObject():
	newPosition += 195
	transform.origin.y = newPosition
	
	
func destroyObject(value):
	transform.origin.x = value * positionHammer
	var jump = abs(value - 1)
	var parabola = abs(pow(jump, 2) - jump)
	transform.origin.y = sin(parabola) * -600
	
