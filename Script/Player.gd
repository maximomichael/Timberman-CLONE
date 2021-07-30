extends Node2D

onready var skinIdle = get_node("Skin/Idle")
onready var skinHammer = get_node("Skin/Hammer")
onready var skinDeath = get_node("Skin/Death")
onready var skin = get_node("Skin")

var positionPlayer = false #False = Right; True = Left;
var playerStop = false

func _ready():
	GameControl.connect("LossGame", self, "died")
	GameControl.connect("WinGame", self, "win")
	
func _input(event):
	if !playerStop and event.is_pressed():
		#Ir para esquerda
		if(event.position.x > 360.0):
			positionPlayer = true
			GameControl.NewClick(-1)
		#ir para direita
		else:
			positionPlayer = false
			GameControl.NewClick(1)
		
		AnimSkin()

func AnimSkin():	
	#mudar posição
	if positionPlayer:
		skin.global_transform.origin.x = 540.0
	else:
		skin.global_transform.origin.x = 180.0
	
	#Flipar player
	skinIdle.flip_h = positionPlayer
	skinHammer.flip_h = positionPlayer
	yield(get_tree().create_timer(.01), "timeout")
	
	#Execultar animação
	skinIdle.visible = !skinIdle.visible
	skinHammer.visible = !skinHammer.visible	
	yield(get_tree().create_timer(.02), "timeout")
	skinIdle.visible = !skinIdle.visible
	skinHammer.visible = !skinHammer.visible

func win():
	playerStop = true
	yield(get_tree().create_timer(.8), "timeout")
	resetVar()
	get_tree().reload_current_scene()

func died():
	playerStop = true
	skinIdle.visible = false
	skinHammer.visible = false
	skinDeath.visible = true
	yield(get_tree().create_timer(.8), "timeout")
	resetVar()
	get_tree().reload_current_scene()
	
func resetVar():
	GameControl.score = 0
	GameControl.time = 0
	GameControl.pauseTime = false


	
