extends Node2D


onready var BARRELS = [
	preload("res://scenes/BarrelFriend.tscn"),
	preload("res://scenes/BarrelEnemyLeft.tscn"),
	preload("res://scenes/BarrelEnemyRight.tscn")
]

export(NodePath) var container

var listBarrel = []
var barrelNull = preload("res://scenes/BarrelNull.tscn")
var distanceY = -195.0
var positionMore = 0.0
var oldBarrel = 0
var level = GameControl.level
var quantBarrel = 40 + (5 * level)
var quantDestroyBarrel = quantBarrel

func _ready():
	randomize()
	generatorIni()
# warning-ignore:return_value_discarded
	GameControl.connect("ClickPlayer", self, "HitBarrel")
	
func generatorIni():	

	for valueCount in range(quantBarrel):
		if valueCount < 2:
			listBarrel.append(BARRELS[0])
		else:
			listBarrel.append(BARRELS[randBarrel()])
		quantBarrel -= 1	 
		
	
	listBarrel.append(barrelNull)
		
	for printList in listBarrel:
		var newBarrel = printList.instance()
		newBarrel.global_transform.origin.y = positionMore
		newBarrel.newPosition = positionMore
		positionMore += distanceY
		add_child(newBarrel)


func HitBarrel(positionPlayer):
	#Position: -1 = Left; 1 = Right
	
	quantDestroyBarrel -= 1	
	if quantDestroyBarrel <= 0 and !verifyEnemy(positionPlayer):
		GameControl.playerWin()
		
	if verifyEnemy(positionPlayer):
		GameControl.playerDied()
		return
	else:
		GameControl.newPoint()
		listBarrel.remove(0)
		get_child(0).destroy(positionPlayer)
		
		#Trocando child
		var barrelDel = get_child(0)
		remove_child(get_child(0))
		get_node(container).add_child(barrelDel)
	
		for object in get_children():
			if object.has_method("modeObject"):
				object.modeObject()
		
	if verifyEnemy(positionPlayer):
		GameControl.playerDied()
		return
		
func randBarrel():
	var newNumber = int(rand_range(0, BARRELS.size()))
	if newNumber == 1 or newNumber == 2:
		if oldBarrel == 0:
			oldBarrel = newNumber
			return newNumber
		elif oldBarrel != newNumber:
			return 0
		elif oldBarrel == newNumber:
			oldBarrel = newNumber
			return newNumber
	else:
		oldBarrel = newNumber
		return newNumber

func verifyEnemy(positionPlayer):
	if positionPlayer == -1 and get_child(0).typeBarrel == 2:
		return true
	#position Right
	elif positionPlayer == 1 and get_child(0).typeBarrel == 1:
		return true
	else:
		return false
		
func verifyDied():
	GameControl.playerDied()
